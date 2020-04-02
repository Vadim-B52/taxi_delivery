import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxi_delivery/src/domain/domain.dart';

import '../domain/my_tasks.dart';

import '../strings.dart';
import '../widgets/card_header.dart';
import '../widgets/common.dart';

class ApplicationMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _buildTasksState(),
    );
  }

  // FutureBuilder
  Widget _buildTasksState() {
    return Consumer<MyTasks>(
      builder: (context, myTasks, child) {
        if (myTasks.isUpToDate) {
          final err = myTasks.error;
          if (err == null) {
            if (myTasks.currentState.tasks.isEmpty) {
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

  Widget _errorTasksState(BuildContext context, MyTasks tasks) {
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

  Widget _emptyTasksState(BuildContext context, MyTasks tasks) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TitleCardHeader(tasks.currentState.summary),
          _buildCheckStatusButton(context, tasks),
        ],
      ),
    );
  }

  Widget _fullTasksState(BuildContext context, MyTasks tasks) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
              TitleCardHeader(tasks.currentState.summary),
            ] +
            _buildRouteItems(context, tasks.currentState.tasks) +
            [_buildNextButton(context, tasks.currentState)],
      ),
    );
  }

  Widget _buildCheckStatusButton(BuildContext context, MyTasks tasks) {
    return Container(
      padding: const EdgeInsets.all(2 * UI.m),
      child: RaisedButton(
        onPressed: () {
          tasks.fetch();
        },
        child: Container(
          padding: EdgeInsets.all(2 * UI.m),
          child: Text("Проверить еще раз"),
        ),
      ),
    );
  }

  Widget _buildNextButton(BuildContext context, TasksState state) {
    final firstTask = state.tasks.first;
    switch (firstTask.type) {
      case MinitaskType.pickup:
        return _buildPickupButton(context, state);
      case MinitaskType.delivery:
        return _buildDeliverButton(context, state);
    }
  }

  Widget _buildPickupButton(BuildContext context, TasksState state) {
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

  Widget _buildDeliverButton(BuildContext context, TasksState state) {
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
