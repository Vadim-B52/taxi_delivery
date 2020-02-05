import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'common_widgets.dart';
import 'strings.dart';

class _UI {
  static const double m = 8;
}

class DeliveryPage extends StatelessWidget {
  final String addressText = 'улица Льва Толстого, 16\nМосква, Хамовники';
  final DateTime deliveryDate = DateTime(2020, 3, 2, 12, 30);
  final List<String> actions = ['directions', 'call', 'here'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          _addressSection(context),
          _divider(context),
          _TimeSection(deliveryDate),
          _divider(context),
          _actionsSection(context),
          _divider(context),
          _ordersSection(context),
        ],
      ),
    );
  }

  Widget _addressSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2 * _UI.m),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Text(
              Strings.deliverToTheAddress,
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            padding: const EdgeInsets.only(bottom: 0.5 * _UI.m),
          ),
          Text(
            addressText,
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 15),
          ),
        ],
      ),
    );
  }

  Widget _actionsSection(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(2 * _UI.m),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: actions.map(this._action).where((x) => x != null).toList(),
        ));
  }

  Widget _action(String type) {
    switch (type) {
      case 'directions':
        return FloatingActionButton(
          onPressed: () => {},
          child: Icon(Icons.directions),
          tooltip: Strings.directions,
        );
      case 'call':
        return FloatingActionButton(
          onPressed: () => {},
          child: Icon(Icons.call),
          tooltip: Strings.call,
        );
      case 'here':
        return FloatingActionButton(
          onPressed: () => {},
          child: Icon(Icons.flag),
          tooltip: Strings.iAmHere,
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
        padding: const EdgeInsets.all(2 * _UI.m),
      ),
      _OrderItem.defaultItem(),
      _OrderItem.defaultItem(),
      _OrderItem.defaultItem(),
    ]);
  }

  Widget _divider(BuildContext context) =>
      Divider(
        indent: 2 * _UI.m,
        endIndent: 2 * _UI.m,
      );
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
    const oneSec = const Duration(seconds: 1);
    updateMinutesLeft();
    _timer = Timer.periodic(
        oneSec,
            (Timer timer) =>
            setState(() {
              updateMinutesLeft();
            }));
  }

  void updateMinutesLeft() {
    _timeLeft = deliveryDate.difference(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2 * _UI.m),
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

  String deliveryTimeText() =>
      _timeLeft.inSeconds % 2 == 0
          ? DateFormat("HH:mm").format(deliveryDate)
          : DateFormat("HH mm").format(deliveryDate);

  TextStyle timeLeftTextStyle() {
    if (deliveryDate.compareTo(DateTime.now()) > 0) {
      return timeTextStyle();
    }
    return noTimeTextStyle();
  }

  TextStyle timeTextStyle() =>
      TextStyle(
        fontSize: 21,
        fontWeight: FontWeight.bold,
      );

  TextStyle noTimeTextStyle() =>
      TextStyle(
        fontSize: 21,
        fontWeight: FontWeight.bold,
        color: Colors.red,
      );

  TextStyle detailsTextStyle() =>
      TextStyle(
        fontSize: 13,
        color: Colors.grey[500],
      );
}

class _OrderItem extends StatelessWidget {
  bool isMarked;
  String recipientInitials;
  String recipientName;
  String orderSummary;
  String orderStatus;

  _OrderItem(this.isMarked, this.recipientInitials, this.recipientName,
      this.orderSummary, this.orderStatus);

  static _OrderItem defaultItem() {
    return _OrderItem(true, 'DH', 'Doctor House',
        'Order #1234, 1 item', 'wait delivery');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding:
        EdgeInsets.only(left: 2 * _UI.m, right: 2 * _UI.m, bottom: _UI.m),
        child: Container(
          decoration: BoxDecoration(
            border: _buildBorder(),
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(2 * _UI.m),
                child: _buildInitials(),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    recipientName,
                  ),
                  Text(
                    orderSummary,
                  ),
                  Text(
                    orderStatus,
                  )
                ],
              ),
              Spacer(),
              Icon(
                Icons.info,
              ),
            ],
          ),
        ));
  }

  Border _buildBorder() =>
      Border(
        left: BorderSide(
          width: _UI.m,
          color: Colors.yellow,
        ),
        right: _buildBorderSide(),
        top: _buildBorderSide(),
        bottom: _buildBorderSide(),
      );

  Container _buildInitials() =>
      Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.red,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              recipientInitials,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.normal,
                fontSize: 24,
              ),
            )
          ],
        ),
      );

  BorderSide _buildBorderSide() =>
      BorderSide(
        color: Colors.grey[300],
      );
}
