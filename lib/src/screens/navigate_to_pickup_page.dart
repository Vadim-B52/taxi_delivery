import 'package:flutter/material.dart';

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

  final List<String> contextActions = ['directions', 'call', 'here'];

  @override
  Widget build(BuildContext context) {
    final NavigateToPickupPageArguments args = ModalRoute.of(context).settings.arguments;
    final minitask = args.minitask;

    return Scaffold(
      appBar: AppBar(title: Text('Идите на забор')),
      body: ListView(
        children: <Widget>[
          _addressSection(context, minitask),
          Dividers.divider(),
          TimeSection(DateTime(2020, 04, 12)),
          Dividers.divider(),
          _actionsSection(context),
          Dividers.divider(),
          _nextAction(),
          _callToCenterAction(),
          _backAction(),
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
    child: Text('Перейти к забору посылок'),
  );

  Widget _callToCenterAction() => RaisedButton(
    onPressed: () => {},
    child: Text('Позвонить оператору'),
  );

  Widget _backAction() => RaisedButton(
    onPressed: () => {},
    child: Text('назад'),
  );

}

