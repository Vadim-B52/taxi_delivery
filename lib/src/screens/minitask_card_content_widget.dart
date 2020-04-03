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

  Widget _buildInRoute(BuildContext context, Minitask minitask) => 
      ListView(
      children: <Widget>[
        _addressSection(context, minitask),
        Dividers.divider(),
        TimeSection(DateTime(2020, 04, 12)),
        Dividers.divider(),
        _actionsSection(context, minitask),
        Dividers.divider(),
        _inactiveNextAction(context),
        _callToCenterAction(context),
        _backAction(context),
      ],
    );

  Widget _buildInProgress(BuildContext context, Minitask minitask) =>
      ListView(
        children: <Widget>[
          _addressSection(context, minitask),
          Dividers.divider(),
          _nextAction(context),
          _callToCenterAction(context),
          _backAction(context),
        ],
      );

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
          children: [
            Buttons.roundButton(context,
                icon: Icons.directions,
                title: 'Навигация',
                onPressed: () => launch("yandexnavi://")),
            Buttons.roundButton(context,
                icon: Icons.flag,
                title: 'На месте',
                onPressed: () => dailyQuest.arriveAtMinitask()),
          ],
        ));
  }

  Widget _inactiveNextAction(BuildContext context) => Buttons.primaryButton(context,
      title: Strings.beginParcelAcceptance, onPressed: null);

  Widget _nextAction(BuildContext context) =>
      Buttons.primaryButton(context,
          title: Strings.beginParcelAcceptance, onPressed: () =>
              Navigator.pushNamed(context, '/acceptance')
      );

  Widget _callToCenterAction(BuildContext context) =>
      Buttons.helpButton(context,
          title: Strings.callToCenter,
          onPressed: () => launch("tel://21213123123"));

  Widget _backAction(BuildContext context) => Buttons.secondaryButton(context,
      title: Strings.back, onPressed: () => dailyQuest.back());
}
