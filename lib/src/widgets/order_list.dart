import 'package:flutter/material.dart';

import '../domain/domain.dart';
import '../strings.dart';
import 'common.dart';
import 'order_item.dart';

typedef OrderListCallback = void Function(Package);

class OrderList extends StatelessWidget {
  final Set<PackageStatus> acceptedStatuses;
  final List<Package> packages;
  final OrderListCallback callback;

  const OrderList({
    Key key,
    this.acceptedStatuses,
    this.packages,
    this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final packageItems = packages
        .where((p) =>
            acceptedStatuses == null || acceptedStatuses.contains(p.status))
        .map<Widget>((p) => _packageWidget(p, callback))
        .toList();

    if (packageItems.isEmpty) {
      return Container();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
            Container(
              child: Text(
                Strings.orders,
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              padding: EdgeInsets.all(2 * UI.m),
            )
          ] +
          packageItems,
    );
  }

  Widget _packageWidget(Package package, OrderListCallback callback) {
    return GestureDetector(
      child: OrderItem(
        isMarked: false,
        recipientInitials: package.customer.initials,
        recipientName: package.customer.fullName,
        orderSummary: '',
        orderStatus: package.status.toString(),
      ),
      onTap: () {
        if (callback != null) {
          callback(package);
        }
      },
    );
  }
}
