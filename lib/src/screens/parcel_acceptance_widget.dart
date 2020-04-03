import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxi_delivery/src/domain/domain.dart';

import '../domain/daily_quest.dart';
import '../widgets/common.dart';

class ParcelAcceptanceWidget extends StatelessWidget {
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
            return ParcelAcceptanceForm(dailyQuest: dailyQuest);
          } else {
            return _buildComplete(context);
          }
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _buildComplete(BuildContext context) => ListView(
        children: <Widget>[
          Buttons.secondaryButton(
            context,
            title: "Больше нет посылок",
            onPressed: () => Navigator.pop(context),
          ),
        ],
      );
}

class ParcelAcceptanceForm extends StatefulWidget {
  final DailyQuest dailyQuest;

  const ParcelAcceptanceForm({Key key, this.dailyQuest}) : super(key: key);

  @override
  _ParcelAcceptanceFormState createState() => _ParcelAcceptanceFormState();
}

class _ParcelAcceptanceFormState extends State<ParcelAcceptanceForm> {
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
        TextField(
          controller: textEditingController,
          decoration: InputDecoration(
              border: InputBorder.none, hintText: 'Номер посылки'),
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
      ],
    );
  }
}
