import 'dart:collection';

import 'package:flutter/foundation.dart';

import '../api/endpoint_provider.dart';
import '../sal/get_tasks.dart';
import 'domain.dart';

class MyTasks extends ChangeNotifier {

  EndpointProvider _endpointProvider = EndpointProvider();

  TasksState _currentState = TasksState(summary: "", tasks: new List<Minitask>());
  String _error = null;
  bool _isUpToDate = false;

  TasksState get currentState => _currentState;
  String get error => _error;
  bool get isUpToDate => _isUpToDate;

  void fetch() async {
    _isUpToDate = false;
    notifyListeners();
    final tasksState = await getTasks(_endpointProvider.endpoint);
    _currentState = tasksState;
    _error = null;
    notifyListeners();
  }
}

class TasksState {
  final String summary;
  final List<Minitask> _tasks;

  UnmodifiableListView<Minitask> get tasks => UnmodifiableListView(_tasks);

  TasksState({@required this.summary, @required tasks}) : _tasks = tasks;
}
