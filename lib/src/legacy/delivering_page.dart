import 'dart:async';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import '../widgets/common.dart';
import '../widgets/order_item.dart';
import '../strings.dart';
import '../widgets/card_header.dart';

class DeliveryPage extends StatelessWidget {
  final String addressText = 'улица Льва Толстого, 16\nМосква, Хамовники';
  final DateTime deliveryDate = DateTime(2020, 3, 2, 12, 30);
  final List<String> actions = ['directions', 'call', 'here'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Delivery Page')),
      body: ListView(
        children: <Widget>[
          _addressSection(context),
          Dividers.divider(),
          _TimeSection(deliveryDate),
          Dividers.divider(),
          _actionsSection(context),
          Dividers.divider(),
          _ordersSection(context),
        ],
      ),
    );
  }

  Widget _addressSection(BuildContext context) {
    return TitleDetailsCardHeader(
      title: Strings.deliverToTheAddress,
      details: addressText,
    );
  }

  Widget _actionsSection(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(2 * UI.m),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: actions.map(this._action).where((x) => x != null).toList(),
        ));
  }

  Widget _action(String type) {
    switch (type) {
      case 'directions':
        return RawMaterialButton(
          onPressed: () => {},
          child: Icon(Icons.directions),
          shape: CircleBorder(),
          fillColor: Colors.grey[300],
          padding: EdgeInsets.all(15.0),
        );
      case 'call':
        return RawMaterialButton(
          onPressed: () => {},
          child: Icon(Icons.call),
          shape: CircleBorder(),
          fillColor: Colors.grey[300],
          padding: EdgeInsets.all(15.0),
        );
      case 'here':
        return RawMaterialButton(
          onPressed: () => {},
          child: Icon(Icons.flag),
          shape: CircleBorder(),
          fillColor: Colors.grey[300],
          padding: EdgeInsets.all(15.0),
        );
      default:
        assert(false, "Unknown type");
        return null;
    }
  }

  Widget _ordersSection(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
      ),
      defaultOrderItem(),
      defaultOrderItem(),
      defaultOrderItem(),
      defaultOrderItem(),
      defaultOrderItem(),
      defaultOrderItem(),
    ]);
  }

  Widget defaultOrderItem() {
    return OrderItem(
        isMarked: true,
        recipientInitials: 'DH',
        recipientName: 'Doctor House Doctor House Doctor House Doctor House',
        orderSummary: 'Order #1234, 1 item',
        orderStatus: 'wait delivery');
  }

}

class _TimeSection extends StatefulWidget {
  final DateTime deliveryDate;

  _TimeSection(this.deliveryDate);

  @override
  State<StatefulWidget> createState() => _TimeSectionState(deliveryDate);
}

class _TimeSectionState extends State<_TimeSection> {
  final DateTime deliveryDate;
  Timer _timer;
  Duration _timeLeft;

  _TimeSectionState(this.deliveryDate);

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    final oneSec = Duration(seconds: 1);
    updateMinutesLeft();
    _timer = Timer.periodic(
        oneSec,
        (Timer timer) => setState(() {
              updateMinutesLeft();
            }));
  }

  void updateMinutesLeft() {
    _timeLeft = deliveryDate.difference(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2 * UI.m),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Column(
            children: [
              Text(
                deliveryTimeText(),
                style: timeTextStyle(),
              ),
              Text(
                Strings.deliveryTime,
                style: detailsTextStyle(),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Text(
                '${_timeLeft.inMinutes} min',
                style: timeLeftTextStyle(),
              ),
              Text(
                Strings.timeLeft,
                style: detailsTextStyle(),
              ),
            ],
          )
        ],
      ),
    );
  }

  String deliveryTimeText() => _timeLeft.inSeconds % 2 == 0
      ? DateFormat("HH:mm").format(deliveryDate)
      : DateFormat("HH mm").format(deliveryDate);

  TextStyle timeLeftTextStyle() {
    if (deliveryDate.compareTo(DateTime.now()) > 0) {
      return timeTextStyle();
    }
    return noTimeTextStyle();
  }

  TextStyle timeTextStyle() => TextStyle(
        fontSize: 21,
        fontWeight: FontWeight.bold,
      );

  TextStyle noTimeTextStyle() => TextStyle(
        fontSize: 21,
        fontWeight: FontWeight.bold,
        color: Colors.red,
      );

  TextStyle detailsTextStyle() => TextStyle(
        fontSize: 13,
        color: Colors.grey[500],
      );
}