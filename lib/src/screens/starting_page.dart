import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxi_delivery/src/domain/domain.dart';
import 'package:taxi_delivery/src/screens/navigate_to_pickup_page.dart';

import '../domain/daily_quest.dart';

import '../strings.dart';
import '../widgets/card_header.dart';
import '../widgets/common.dart';

class StartingPage extends StatelessWidget {
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
      builder: (context, myTasks, child) {
        if (myTasks.isUpToDate) {
          final err = myTasks.error;
          if (err == null) {
            if (myTasks.minitasks.tasks.isEmpty) {
              return _emptyTasksState(context, myTasks);
            } else {
              return _fullTasksState(context, myTasks);
            }
          } else {
            return _errorTasksState(context, myTasks);
          }
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _errorTasksState(BuildContext context, DailyQuest tasks) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TitleCardHeader("Что-то пошло не так"),
          _buildCheckStatusButton(context, tasks),
        ],
      ),
    );
  }

  Widget _emptyTasksState(BuildContext context, DailyQuest tasks) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TitleCardHeader(tasks.minitasks.summary),
          _buildCheckStatusButton(context, tasks),
        ],
      ),
    );
  }

  Widget _fullTasksState(BuildContext context, DailyQuest tasks) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
              TitleCardHeader(tasks.minitasks.summary),
            ] +
            _buildRouteItems(context, tasks.minitasks.tasks) +
            [_buildNextButton(context, tasks.minitasks)],
      ),
    );
  }

  Widget _buildCheckStatusButton(BuildContext context, DailyQuest tasks) {
    return Container(
      padding: const EdgeInsets.all(2 * UI.m),
      child: RaisedButton(
        onPressed: () {
          tasks.checkStatus();
        },
        child: Container(
          padding: EdgeInsets.all(2 * UI.m),
          child: Text("Проверить еще раз"),
        ),
      ),
    );
  }

  Widget _buildNextButton(BuildContext context, MinitaskList state) {
    final firstTask = state.tasks.first;
    switch (firstTask.type) {
      case MinitaskType.pickup:
        return _buildPickupButton(context, state);
      case MinitaskType.delivery:
        return _buildDeliverButton(context, state);
    }
  }

  Widget _buildPickupButton(BuildContext context, MinitaskList state) {
    return Container(
      padding: const EdgeInsets.all(2 * UI.m),
      child: RaisedButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            '/navigate_to_pickup',
            arguments: NavigateToPickupPageArguments(
                minitask: state.tasks.first),
          );
        },
        child: Container(
          padding: EdgeInsets.all(2 * UI.m),
          child: Text(Strings.pickupParcels),
        ),
      ),
    );
  }

  Widget _buildDeliverButton(BuildContext context, MinitaskList state) {
    return Container(
      padding: const EdgeInsets.all(2 * UI.m),
      child: RaisedButton(
        onPressed: () {},
        child: Container(
          padding: EdgeInsets.all(2 * UI.m),
          child: Text(Strings.deliverParcels),
        ),
      ),
    );
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
