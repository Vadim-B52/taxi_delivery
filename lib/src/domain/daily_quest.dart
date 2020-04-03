import 'dart:collection';

import 'package:flutter/foundation.dart';

import '../api/endpoint_provider.dart';
import '../sal/get_tasks.dart';
import 'domain.dart';

abstract class DailyQuestActions {
  void checkStatus();
  void getMinitask();
  void arriveAtMinitask();
  void startMinitask();
  
  void confirmPickup();
  void declinePickup();
  void confirmDelivery();
  void declineDelivery();
}

class DailyQuest extends ChangeNotifier implements DailyQuestActions {

  EndpointProvider _endpointProvider = EndpointProvider();

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
    await _getState();
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

  void confirmPickup() {}

  void declinePickup() {}

  void confirmDelivery() {}

  void declineDelivery() {}

  Future<DailyQuest> _getState() {
    _isUpToDate = false;
    notifyListeners();
    final tasks = getTasks(_endpointProvider.endpoint);
    tasks.then((tasksState) {
      _isUpToDate = true;
      _error = null;
      _minitasks = tasksState;
      notifyListeners();
    });
    tasks.catchError((onError) {
      _error = "Something went wrong";
      _isUpToDate = true;
      notifyListeners();
    });
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
