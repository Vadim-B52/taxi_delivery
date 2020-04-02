import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../domain/my_tasks.dart';

import '../adventures/pickup_adventure.dart';
import '../strings.dart';
import '../widgets/card_header.dart';
import '../widgets/common.dart';

class ApplicationMainArguments {
  final RouteItem store;

  ApplicationMainArguments({this.store});
}

class ApplicationMain extends StatelessWidget {

  final MyTasks tasks = new MyTasks();

  @override
  Widget build(BuildContext context) {

    tasks.fetch();

    final ApplicationMainArguments args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(),
      body: _buildCard(context, args.store),
    );
  }

  Widget _buildCard(BuildContext context, RouteItem store) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          DetailsCardHeader(store.shortText),
          Dividers.divider(),
          _buildStartAcceptanceButton(),
          _buildCallOperatorButton(),
          _buildBackButton(),
        ],
      ),
    );
  }

  Widget _buildStartAcceptanceButton() {
    return Container(
      padding: const EdgeInsets.all(2 * UI.m),
      child: RaisedButton(
        onPressed: () {},
        child: Container(
          padding: EdgeInsets.all(2 * UI.m),
          child: Text(Strings.pickupParcels),
        ),
      ),
    );
  }

  Widget _buildCallOperatorButton() {
    return Container(
      padding: const EdgeInsets.all(2 * UI.m),
      child: RaisedButton(
        onPressed: () {},
        child: Container(
          padding: EdgeInsets.all(2 * UI.m),
          child: Text(Strings.pickupParcels),
        ),
      ),
    );
  }


  Widget _buildBackButton() {
    return Container(
      padding: const EdgeInsets.all(2 * UI.m),
      child: RaisedButton(
        onPressed: () {},
        child: Container(
          padding: EdgeInsets.all(2 * UI.m),
          child: Text(Strings.pickupParcels),
        ),
      ),
    );
  }

  List<Widget> _buildRouteItems(BuildContext context, PickupRoute route) {
    final items = <Widget>[];
    final store = route.store;
    route.deliveryRoute.forEach((itm) {
      items.add(_buildRouteItem(context, itm.shortText, itm.dateTime));
      items.add(Dividers.divider());
    });
    return items;
  }

  Widget _buildStoreItem(BuildContext context, String text, DateTime time) {
    return Container(
      padding: const EdgeInsets.only(left: 2 * UI.m, right: 2 * UI.m),
      child: Row(
        children: <Widget>[
          Container(
            child: Icon(Icons.store),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(2 * UI.m),
              child: RichText(
                text: TextSpan(
                  style: TextStyle(color: Colors.black),
                  children: [
                    TextSpan(
                      text: Strings.pickup,
                      style: Theme.of(context).textTheme.body2,
                    ),
                    TextSpan(
                      text: text,
                      style: Theme.of(context).textTheme.body1,
                    ),
                  ],
                ),
              ),
            ),
          ),
          _buildTimeText(time),
        ],
      ),
    );
  }

  Widget _buildRouteItem(BuildContext context, String text, DateTime time) {
    return Container(
      padding: const EdgeInsets.only(left: 2 * UI.m, right: 2 * UI.m),
      child: Row(
        children: <Widget>[
          Container(
            child: Icon(Icons.radio_button_checked),
          ),
          Expanded(
            child: Container(
                padding: const EdgeInsets.all(2 * UI.m),
                child: Text(
                  text,
                  style: Theme.of(context).textTheme.body1,
                )),
          ),
          _buildTimeText(time),
        ],
      ),
    );
  }

  Text _buildTimeText(DateTime time) {
    return Text(
      DateFormat('HH:mm').format(time),
      textAlign: TextAlign.end,
    );
  }
}
