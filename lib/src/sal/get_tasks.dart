import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:taxi_delivery/src/dto/address_to.dart';
import 'package:taxi_delivery/src/dto/package_to.dart';

import '../api/endpoint.dart';
import '../domain/domain.dart';
import '../domain/daily_quest.dart';
import '../dto/get_tasks_response_to.dart';
import '../dto/task_to.dart';

Future<MinitaskList> getTasks(Endpoint endpoint) async {
  final response = await endpoint.get('/gettasks');
  if (response.statusCode == 200) {
    return compute(_parseTasksState, response.body);
  } else {
    throw Exception('Failed to load tasks');
  }
}

MinitaskList _parseTasksState(String responseBody) {
  final parsed = json.decode(responseBody);
  final response = GetTasksResponseTO.fromJson(parsed);

  return MinitaskList(
      summary: response.summary,
      tasks: response.tasks.map<Minitask>(_taskToDomain).toList());
}

Minitask _taskToDomain(TaskTO task) => Minitask(
      id: task.id,
      type: _taskTypeToDomain(task.type),
      address: _addressToDomain(task.address),
      description: task.description,
      packages: task.packages.map<Package>(_packageToDomain).toList(),
    );

// TODO:
MinitaskType _taskTypeToDomain(String type) {
  switch (type) {
    case 'pickup':
      return MinitaskType.pickup;
    case 'delivery':
      return MinitaskType.delivery;
    case 'backup':
      return MinitaskType.backup;
  }
}

Address _addressToDomain(AddressTO address) => Address(
    shortText: address.shortString,
    coordinate: Coordinate(
      latitude: address.ll[0],
      longitude: address.ll[1],
    ));

Package _packageToDomain(PackageTO package) => Package(
      id: package.id,
      status: _packageStatusToDomain(package.status),
      customer: Customer(
          name: package.customer.name,
          surname: package.customer.surname,
          phone: package.customer.phone),
    );

// TODO:
PackageStatus _packageStatusToDomain(String status) {
  switch (status) {
    case 'pending':
      return PackageStatus.pending;
    case 'picked':
      return PackageStatus.picked;
    case 'delivered':
      return PackageStatus.delivered;
    case 'declinedByCustomer':
      return PackageStatus.declinedByCustomer;
    case 'declinedByCourier':
      return PackageStatus.declinedByCourier;
  }
}
