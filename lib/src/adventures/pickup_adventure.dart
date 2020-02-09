import 'package:flutter/foundation.dart';

class PickupRoute {
  final RouteItem store;
  final List<RouteItem> deliveryRoute;

  PickupRoute({@required this.store, @required this.deliveryRoute});

  static PickupRoute exampleData() {
    return PickupRoute(
        store: RouteItem(
            shortText: 'Маркет курьер',
            dateTime: DateTime(2020, 02, 12, 12, 0)),
        deliveryRoute: [
          RouteItem(
              shortText: 'ул. Белевская',
              dateTime: DateTime(2020, 02, 12, 16, 09))
        ]);
  }
}

class RouteItem {
  final String shortText;
  final DateTime dateTime;

  RouteItem({@required this.shortText, @required this.dateTime});
}
