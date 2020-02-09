import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../adventures/b/pickup_adventure.dart';
import '../strings.dart';
import '../widgets/card_header.dart';
import '../widgets/common.dart';

class PickupPageArguments {
  final PickupRoute route;

  PickupPageArguments({this.route});
}

class PickupPage extends StatelessWidget {
  final CameraPosition _moscow = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14,
  );

  @override
  Widget build(BuildContext context) {
    final PickupPageArguments args = ModalRoute
        .of(context)
        .settings
        .arguments;

    return Scaffold(
      appBar: AppBar(),
      body: SlidingUpPanel(
        body: _buildMap(),
        panel: _buildCard(args.route),
      ),
    );
  }

  Widget _buildMap() {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: _moscow,
    );
  }

  Widget _buildCard(PickupRoute route) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TitleCardHeader(Strings.todayRoute)
        ] +
            _buildRouteItems(route) +
            [
              RaisedButton(
                onPressed: () {},
                child: Text(Strings.pickupParcels),
              ),
            ],
      ),
    );
  }

  List<Widget> _buildRouteItems(PickupRoute route) {
    final items = <Widget>[];
    final store = route.store;
    items.add(_buildRouteItem(Icons.store, store.shortText, store.dateTime));
    items.add(Divider());
    route.deliveryRoute.forEach((itm) {
      items.add(_buildRouteItem(
          Icons.radio_button_checked, itm.shortText, itm.dateTime));
      items.add(Divider());
    });
    return items;
  }

  Widget _buildRouteItem(IconData icon, String text, DateTime time) {
    return Row(
      children: <Widget>[
        Container(
          child: Icon(icon),
        ),
        Expanded(
          child: Container(
              padding: EdgeInsets.all(16),
              child: Text(
                text,
                style: TextStyles.textStyleRegular(),
              )),
        ),
        Text(
          DateFormat('HH:mm').format(time),
          textAlign: TextAlign.end,
        ),
      ],
    );
  }
}
