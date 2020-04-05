import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

import '../domain/daily_quest.dart';
import '../domain/domain.dart';
import '../strings.dart';
import '../widgets/card_header.dart';
import '../widgets/common.dart';
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

  Widget _buildInRoute(BuildContext context, Minitask minitask) => ListView(
        children: <Widget>[
          _addressSection(context, minitask),
          Dividers.divider(),
          TimeSection(minitask.deadline),
          Dividers.divider(),
          _actionsSection(context, minitask),
          Dividers.divider(),
          _inactiveNextAction(context, minitask),
          _callToCenterAction(context),
          _backAction(context),
        ],
      );

  Widget _buildInProgress(BuildContext context, Minitask minitask) => ListView(
        children: <Widget>[
          _addressSection(context, minitask),
          Dividers.divider(),
          _nextAction(context, minitask),
          _callToCenterAction(context),
          _backAction(context),
        ],
      );

  Widget _addressSection(BuildContext context, Minitask minitask) {
    return TitleDetailsCardHeader(
      title: minitask.description,
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

  Widget _inactiveNextAction(BuildContext context, Minitask minitask) {
    return Buttons.primaryButton(
      context,
      title: _nextButtonTitle(minitask),
      onPressed: null,
    );
  }

  Widget _nextAction(BuildContext context, Minitask minitask) {
    return Buttons.primaryButton(
      context,
      title: _nextButtonTitle(minitask),
      onPressed: () => Navigator.pushNamed(context, '/acceptance'),
    );
  }

  String _nextButtonTitle(Minitask minitask) {
    switch (minitask.type) {
      case MinitaskType.pickup:
        return Strings.beginParcelAcceptance;
      case MinitaskType.delivery:
        return Strings.beginParcelDelivery;
      case MinitaskType.backup:
        return Strings.beginParcelReturn;
    }
  }

  Widget _callToCenterAction(BuildContext context) =>
      Buttons.helpButton(context,
          title: Strings.callToCenter,
          onPressed: () => launch("tel://21213123123"));

  Widget _backAction(BuildContext context) => Buttons.secondaryButton(context,
      title: Strings.back, onPressed: () => dailyQuest.back());
}
