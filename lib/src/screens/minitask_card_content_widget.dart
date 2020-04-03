import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

import '../domain/daily_quest.dart';

import '../strings.dart';
import '../widgets/card_header.dart';
import '../widgets/common.dart';
import '../domain/domain.dart';
import '../widgets/time_section.dart';

class MinitaskCardContentWidget extends StatelessWidget {
  final DailyQuest dailyQuest;

  // TODO:
  //  <a href="yandexnavi://">Открыть Яндекс.Навигатор</a>
  //  <a href="yandexmaps://maps.yandex.ru/?ll=37.62,55.75&z=12">Открыть карту
  final List<String> contextActions = ['directions', 'here'];

  MinitaskCardContentWidget({this.dailyQuest});

  @override
  Widget build(BuildContext context) {
    final minitask = dailyQuest.currentMinitask;
    final status = dailyQuest.minitaskStatus;
    if (status == MinitaskStatus.inRoute) {
      return _buildInRoute(context, minitask);
    } else {
      return _buildInProgress(context, minitask);
    }
  }

  Widget _buildInRoute(BuildContext context, Minitask minitask) {
    return ListView(
      children: <Widget>[
        _addressSection(context, minitask),
        Dividers.divider(),
        TimeSection(DateTime(2020, 04, 12)),
        Dividers.divider(),
        _actionsSection(context, minitask),
        Dividers.divider(),
        _nextAction(context),
        _callToCenterAction(context),
        _backAction(context),
      ],
    );
  }

  Widget _buildInProgress(BuildContext context, Minitask minitask) {}

  Widget _addressSection(BuildContext context, Minitask minitask) {
    return TitleDetailsCardHeader(
      title: minitask.type == MinitaskType.pickup
          ? "Забор посылок по адресу"
          : "Доставить по адресу",
      details: minitask.address.shortText,
    );
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

  Widget _nextAction(BuildContext context) => Buttons.primaryButton(context,
      text: Strings.beginParcelAcceptance, onPressed: null);

  Widget _callToCenterAction(BuildContext context) =>
      Buttons.helpButton(context,
          text: Strings.callToCenter,
          onPressed: () => launch("tel://21213123123"));

  Widget _backAction(BuildContext context) => Buttons.secondaryButton(context,
      text: Strings.back, onPressed: () => dailyQuest.back());
}
