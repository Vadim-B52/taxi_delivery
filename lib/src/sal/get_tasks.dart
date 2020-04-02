import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:taxi_delivery/src/dto/address_to.dart';

import '../api/endpoint.dart';
import '../domain/domain.dart';
import '../domain/my_tasks.dart';
import '../dto/get_tasks_response_to.dart';
import '../dto/task_to.dart';

Future<TasksState> getTasks(Endpoint endpoint) async {
  final response = await endpoint.get('/gettasks');
  if (response.statusCode == 200) {
    return compute(_parseTasksState, response.body);
  } else {
    throw Exception('Failed to load tasks');
  }
}

TasksState _parseTasksState(String responseBody) {
  final parsed = json.decode(responseBody);
  final response = GetTasksResponseTO.fromJson(parsed);

  return TasksState(
      summary: response.summary,
      tasks: response.tasks.map<Minitask>(_taskToDomain).toList());
}

Minitask _taskToDomain(TaskTO task) => Minitask(
    id: task.id,
    type: _taskTypeToDomain(task.type),
    address: _addressToDomain(task.address),
    description: task.description);

MinitaskType _taskTypeToDomain(String type) {
  switch (type) {
    case 'pickup':
      return MinitaskType.pickup;
    case 'deliver':
      return MinitaskType.delivery;
  }
}

Address _addressToDomain(AddressTO address) =>
    Address(shortText: address.shortString);
