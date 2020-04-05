import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../strings.dart';
import '../widgets/card_header.dart';
import '../widgets/common.dart';
import '../domain/domain.dart';

class BeginPickupPageArguments {
  final Minitask minitask;

  BeginPickupPageArguments({this.minitask});
}

class BeginPickupPage extends StatelessWidget {

  final List<String> contextActions = ['call'];

  @override
  Widget build(BuildContext context) {
    final BeginPickupPageArguments args = ModalRoute.of(context).settings.arguments;
    final minitask = args.minitask;

    return Scaffold(
      appBar: AppBar(title: Text('Идите на забор')),
      body: ListView(
        children: <Widget>[
          _addressSection(context, minitask),
          Dividers.divider(),
          _actionsSection(context),
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

  Widget _actionsSection(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(2 * UI.m),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: contextActions.map(this._action).where((x) => x != null).toList(),
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

  Widget _nextAction() => RaisedButton(
    onPressed: () => {},
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

