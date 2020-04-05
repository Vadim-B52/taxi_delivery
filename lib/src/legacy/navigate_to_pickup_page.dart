import 'package:flutter/material.dart';
import 'package:taxi_delivery/src/legacy/begin_pickup_page.dart';
import 'package:url_launcher/url_launcher.dart';

import '../strings.dart';
import '../widgets/card_header.dart';
import '../widgets/common.dart';
import '../domain/domain.dart';
import '../widgets/time_section.dart';

class NavigateToPickupPageArguments {
  final Minitask minitask;

  NavigateToPickupPageArguments({this.minitask});
}

class NavigateToPickupPage extends StatelessWidget {
//  <a href="yandexnavi://">Открыть Яндекс.Навигатор</a>
//  <a href="yandexmaps://maps.yandex.ru/?ll=37.62,55.75&z=12">Открыть карту
  final List<String> contextActions = ['directions', 'here'];

  @override
  Widget build(BuildContext context) {
    final NavigateToPickupPageArguments args =
        ModalRoute.of(context).settings.arguments;
    final minitask = args.minitask;

    return Scaffold(
      appBar: AppBar(title: Text('Идите на забор')),
      body: ListView(
        children: <Widget>[
          _addressSection(context, minitask),
          Dividers.divider(),
          TimeSection(DateTime(2020, 04, 12)),
          Dividers.divider(),
          _actionsSection(context, minitask),
          Dividers.divider(),
          _nextAction(),
          _callToCenterAction(),
          _backAction(context),
        ],
      ),
    );
  }

  Widget _addressSection(BuildContext context, Minitask minitask) {
    return TitleCardHeader(minitask.address.shortText);
  }

  Widget _actionsSection(BuildContext context, Minitask minitask) {
    return Container(
        padding: EdgeInsets.all(2 * UI.m),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: contextActions
              .map<Widget>((action) => _action(context, minitask, action))
              .where((x) => x != null)
              .toList(),
        ));
  }

  Widget _action(BuildContext context, Minitask minitask, String type) {
    switch (type) {
      case 'directions':
        return RawMaterialButton(
          onPressed: () => launch("yandexnavi://"),
          child: Icon(Icons.directions),
          shape: CircleBorder(),
          fillColor: Colors.grey[300],
          padding: EdgeInsets.all(15.0),
        );
      case 'here':
        return RawMaterialButton(
          onPressed: () => Navigator.pushNamed(
            context,
            '/begin_pickup',
            arguments: BeginPickupPageArguments(minitask: minitask),
          ),
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

  Widget _nextAction() => RaisedButton(
        onPressed: null,
        child: Text(Strings.beginPackageAcceptance),
      );

  Widget _callToCenterAction() => RaisedButton(
        onPressed: () => launch("tel://21213123123"),
        child: Text(Strings.callToCenter),
      );

  Widget _backAction(BuildContext context) => RaisedButton(
        onPressed: () => Navigator.pop(context),
        child: Text(Strings.back),
      );
}
