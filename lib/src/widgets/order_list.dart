import 'package:flutter/material.dart';

import '../domain/domain.dart';
import '../strings.dart';
import 'common.dart';
import 'order_item.dart';

class OrderList extends StatelessWidget {

  final Set<PackageStatus> acceptedStatuses;
  final List<Package> packages;

  const OrderList({Key key, this.acceptedStatuses, this.packages}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final packageItems = packages
        .where((p) => acceptedStatuses == null || acceptedStatuses.contains(p.status))
        .map<Widget>(_packageWidget)
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

  Widget _packageWidget(Package package) {
    return OrderItem(
      isMarked: false,
      recipientInitials: package.customer.initials,
      recipientName: package.customer.fullName,
      orderSummary: '',
      orderStatus: package.status.toString(),
    );
  }
}