import 'package:flutter/foundation.dart';

//minitask:
//  id: <...>
//  type: pickup
//  address: Невский проспект, 42, оф. 7
//  description: Lorem ipsum
//  packages:
//    - package_id: x
//       status: pending
//    - package_id: y
//       status: picked
//    - package_id: z
//       status:
//  actions:
//    - type: начать_забор
//    - type: decline
//      available_reasons:
//        - x
//        - y
//        - z
class Minitask {
  final String id;
  final MinitaskType type;
  final Address address;
  final String description;

  Minitask({@required this.id, @required this.type, @required this.address, @required this.description});
}

enum MinitaskType {
  pickup,
  delivery,
}

class Address {
  final String shortText;

  Address({this.shortText});
}

class Package {
  final String id;

  Package({@required this.id});
}

enum PackageStatus {
  pending, picked
}

//action:
//  task_id: <...>
//  type: decline_pickup
//  reason: x
//  comment: <...>
class Action {
  final String taskId;

  Action({ @required this.taskId });
}

class BeginPickupAction extends Action {
}

class DeclineAction extends Action {
//  final List<DeclineReason> declineReasons;
//  final String comment; // to enter
}

class DeclineReason {
//  final String id;
//  final String text;
}

//action:
//  task_id: <...>
//  type: confirm_pickup
//  packages:
//    - package_id: <...>
//  media_asset: <... base64 encoded data ...>
class ConfirmPickupAction {

}


/*





minitask:
  id: <...>
  type: delivery
  address: Большой проспект, 11, кв. 4
  packages:
    - package_id: <...>
    - package_id: <...>
  actions:
    - type: связаться_с_получателем
      phone: +7 123 456 78 90
    - type: pospone_delivery
    - type: confirm_delivery

action:
  task_id: <...>
  type: postone_delivery
  by:
    value: 2
    unit: hour
  reason: client
  comment: <...>

action:
  task_id: <...>
  type: confirm_delivery
  confirmation_code: v3rySecr3t

minitask:
 - описание
 - доступные действия
 - сабмит результатов для каждого действия

общие действия
 - завершить смену
 - связаться с тех-поддержкой

action:
  type: common_end_day
 */