import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxi_delivery/src/domain/domain.dart';
import 'package:taxi_delivery/src/widgets/order_list.dart';

import '../domain/daily_quest.dart';
import '../widgets/common.dart';

class PackageAcceptanceWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Приемка посылок')),
      body: _buildContent(context),
    );
  }

  // FutureBuilder
  Widget _buildContent(BuildContext context) {
    return Consumer<DailyQuest>(
      builder: (context, dailyQuest, child) {
        if (dailyQuest.isUpToDate) {
          if (dailyQuest.currentMinitask.type == MinitaskType.pickup) {
            return PackageAcceptanceForm(dailyQuest: dailyQuest);
          } else {
            return _buildComplete(context, dailyQuest);
          }
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _buildComplete(BuildContext context, DailyQuest dailyQuest) => ListView(
        children: <Widget>[
          Buttons.secondaryButton(
            context,
            title: "Нечего сканировать",
            onPressed: () => Navigator.pop(context),
          ),
          OrderList(
            acceptedStatuses: _acceptedStatuses(),
            packages: dailyQuest.currentMinitask.packages,
          ),        ],
      );
}

class PackageAcceptanceForm extends StatefulWidget {
  final DailyQuest dailyQuest;

  const PackageAcceptanceForm({Key key, this.dailyQuest}) : super(key: key);

  @override
  _PackageAcceptanceFormState createState() => _PackageAcceptanceFormState();
}

class _PackageAcceptanceFormState extends State<PackageAcceptanceForm> {
  final textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(UI.m),
          child: TextField(
            controller: textEditingController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Номер посылки',
            ),
          ),
        ),
        Buttons.roundButton(context,
            icon: Icons.camera, title: "сканироать", onPressed: null),
        Buttons.primaryButton(context,
            title: "Принять посылку",
            onPressed: () =>
                widget.dailyQuest.confirmPickup(textEditingController.text)),
        Buttons.secondaryButton(context, title: "Отказаться", onPressed: null),
        Buttons.secondaryButton(context,
            title: "Больше нет посылок",
            onPressed: () => Navigator.pop(context)),
        OrderList(
          acceptedStatuses: _acceptedStatuses(),
          packages: widget.dailyQuest.currentMinitask.packages,
        ),
      ],
    );
  }
}

Set<PackageStatus> _acceptedStatuses() {
  final statuses = PackageStatus.values.toSet();
  statuses.remove(PackageStatus.pending);
  return statuses;
}
