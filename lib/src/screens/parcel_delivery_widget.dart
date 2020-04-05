import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../domain/daily_quest.dart';
import '../domain/domain.dart';
import '../widgets/common.dart';
import '../widgets/order_item.dart';

class ParcelDeliveryWidgetArguments {
  final Package package;

  ParcelDeliveryWidgetArguments(this.package);
}

class ParcelDeliveryWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final ParcelDeliveryWidgetArguments args =
        ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(title: Text('Выдача посылки')),
      body: _buildContent(context, args.package),
    );
  }

  // FutureBuilder
  Widget _buildContent(BuildContext context, Package package) {
    return ListView(
      children: <Widget>[
        OrderItem(
          isMarked: true,
          recipientInitials: package.customer.initials,
          recipientName: package.customer.fullName,
          orderSummary: '',
          orderStatus: package.status.toString(),
        ),
      ],
//      OrderItem(
//
//      ),
    );
//    return Consumer<DailyQuest>(
//      builder: (context, dailyQuest, child) {
//        if (dailyQuest.isUpToDate) {
//          if (dailyQuest.currentMinitask.type == MinitaskType.delivery) {
//            return ParcelAcceptanceForm(dailyQuest: dailyQuest);
//          } else {
//            return _buildComplete(context, dailyQuest);
//          }
//        } else {
//          return Center(child: CircularProgressIndicator());
//        }
//      },
//    );
  }

  Widget _buildComplete(BuildContext context, DailyQuest dailyQuest) =>
      ListView(
        children: <Widget>[
          Buttons.secondaryButton(
            context,
            title: "Нечего сканировать",
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
      ],
    );
  }
}
