import 'dart:collection';

import 'package:flutter/foundation.dart';

import '../api/endpoint.dart';
import '../api/endpoint_provider.dart';
import '../sal/confirm_pickup.dart' as confirmPickupClient;
import '../sal/get_tasks.dart';
import 'domain.dart';

abstract class DailyQuestActions {
  void checkStatus();
  void getMinitask();
  void arriveAtMinitask();
  void startMinitask();

  void back();
  
  void confirmPickup(String packageId);
  void declinePickup();
  void confirmDelivery();
  void declineDelivery();
}

class DailyQuest extends ChangeNotifier implements DailyQuestActions {

  EndpointProvider _endpointProvider = EndpointProvider();
  Endpoint get _endpoint => _endpointProvider.endpoint;

  MinitaskList _minitasks = MinitaskList(summary: "", tasks: new List<Minitask>());
  Minitask _currentMinitask;
  MinitaskStatus _minitaskStatus = MinitaskStatus.inRoute;
  String _error;
  bool _isUpToDate = false;

  MinitaskList get minitasks => _minitasks;
  Minitask get currentMinitask => _currentMinitask;
  MinitaskStatus get minitaskStatus => _minitaskStatus;
  String get error => _error;
  bool get isUpToDate => _isUpToDate;

  void checkStatus() async {
    await _getTasks();
  }

  void getMinitask() {
    _currentMinitask = _minitasks.tasks.first;
    _minitaskStatus = MinitaskStatus.inRoute;
    notifyListeners();
  }

  void arriveAtMinitask() {
    _minitaskStatus = MinitaskStatus.inPlace;
    notifyListeners();
  }

  void startMinitask() {
    _minitaskStatus = MinitaskStatus.inProgress;
    notifyListeners();
  }

  void back() {
    if (_currentMinitask == null) {
      return;
    }
    switch (_minitaskStatus) {
      case MinitaskStatus.inRoute:
        _currentMinitask = null;
        break;
      case MinitaskStatus.inPlace:
        _minitaskStatus = MinitaskStatus.inRoute;
        break;
      case MinitaskStatus.inProgress:
        _minitaskStatus = MinitaskStatus.inPlace;
        break;
    }
    notifyListeners();
  }

  void confirmPickup(String packageId) async {
    _isUpToDate = false;
    notifyListeners();
    await confirmPickupClient.confirmPickup(_endpoint, packageId);
    checkStatus();
  }

  void declinePickup() {}

  void confirmDelivery() {}

  void declineDelivery() {}

  Future<MinitaskList> _getTasks() {
    _isUpToDate = false;
    notifyListeners();
    final tasks = getTasks(_endpoint);
    tasks.then((minitasks) {
      _isUpToDate = true;
      _error = null;
      _minitasks = minitasks;
      _updateCurrentMinitask(minitasks);
      notifyListeners();
    });
    tasks.catchError((onError) {
      _error = "Something went wrong";
      _isUpToDate = true;
      notifyListeners();
    });
    return tasks;
  }

  void _updateCurrentMinitask(MinitaskList minitasks) {
    final prev = _currentMinitask;
    if (prev == null) {
      return;
    }
    final first = minitasks.tasks.first;
    if (first == null) {
      _currentMinitask = null;
      _minitaskStatus = MinitaskStatus.inRoute;
    } else if (first.id != prev.id) {
      _currentMinitask = first;
      _minitaskStatus = MinitaskStatus.inRoute;
    } else {
      // NOOP
    }
  }
}

enum MinitaskStatus {
  inRoute,
  inPlace,
  inProgress,
}

class MinitaskList {
  final String summary;
  final List<Minitask> _tasks;

  UnmodifiableListView<Minitask> get tasks => UnmodifiableListView(_tasks);
  bool get isEmpty => _tasks.isEmpty;

  MinitaskList({@required this.summary, @required tasks}) : _tasks = tasks;
}
