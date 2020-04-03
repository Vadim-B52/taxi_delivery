import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxi_delivery/src/domain/domain.dart';
import 'package:taxi_delivery/src/screens/minitask_card_content_widget.dart';
import 'package:taxi_delivery/src/screens/navigate_to_pickup_page.dart';

import '../domain/daily_quest.dart';

import '../strings.dart';
import '../widgets/card_header.dart';
import '../widgets/common.dart';

class DailyQuestCardWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _buildTasksState(),
    );
  }

  // FutureBuilder
  Widget _buildTasksState() {
    return Consumer<DailyQuest>(
      builder: (context, dailyQuest, child) {
        if (dailyQuest.isUpToDate) {
          final err = dailyQuest.error;
          if (err == null) {
            if (dailyQuest.minitasks.isEmpty) {
              return _emptyState(context, dailyQuest);
            } else {
              return _normalState(context, dailyQuest);
            }
          } else {
            return _errorState(context, dailyQuest);
          }
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _errorState(BuildContext context, DailyQuest dailyQuest) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TitleCardHeader("Что-то пошло не так"),
          Buttons.primaryButton(context,
              text: Strings.checkOnceMore,
              onPressed: () => dailyQuest.checkStatus()),
        ],
      ),
    );
  }

  Widget _emptyState(BuildContext context, DailyQuest dailyQuest) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TitleCardHeader(dailyQuest.minitasks.summary),
          Buttons.primaryButton(context,
              text: Strings.checkOnceMore,
              onPressed: () => dailyQuest.checkStatus()),
        ],
      ),
    );
  }

  Widget _normalState(BuildContext context, DailyQuest dailyQuest) {
    final minitask = dailyQuest.currentMinitask;
    if (minitask == null) {
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
                TitleCardHeader(dailyQuest.minitasks.summary),
              ] +
              _buildRouteItems(context, dailyQuest.minitasks.tasks) +
              [_buildNextButton(context, dailyQuest)],
        ),
      );
    }
    return MinitaskCardContentWidget(dailyQuest: dailyQuest);
  }

  Widget _buildNextButton(BuildContext context, DailyQuest dailyQuest) {
    final firstTask = dailyQuest.minitasks.tasks.first;
    final title = firstTask.type == MinitaskType.pickup
        ? Strings.pickupParcels
        : Strings.deliverParcels;

    return Buttons.primaryButton(context,
        text: title, onPressed: () => dailyQuest.getMinitask());
  }

  List<Widget> _buildRouteItems(BuildContext context, List<Minitask> tasks) {
    final items = <Widget>[];
    tasks.forEach((itm) {
      final icon = itm.type == MinitaskType.pickup ? Icons.store : Icons.radio;
      items.add(_buildRouteItem(context, icon, itm.address.shortText, "Время"));
      items.add(Dividers.divider());
    });
    return items;
  }

  Widget _buildRouteItem(
      BuildContext context, IconData icon, String text, String details) {
    return Container(
      padding: const EdgeInsets.only(left: 2 * UI.m, right: 2 * UI.m),
      child: Row(
        children: <Widget>[
          Container(
            child: Icon(icon),
          ),
          Expanded(
            child: Container(
                padding: const EdgeInsets.all(2 * UI.m),
                child: Text(
                  text,
                  style: Theme.of(context).textTheme.body1,
                )),
          ),
          Text(
            details,
            textAlign: TextAlign.end,
          ),
        ],
      ),
    );
  }
}
