import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxi_delivery/src/domain/domain.dart';
import 'package:taxi_delivery/src/widgets/order_item.dart';

import '../domain/daily_quest.dart';
import '../strings.dart';
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
          _packagesSection(context, dailyQuest.currentMinitask.packages),
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
        _packagesSection(context, widget.dailyQuest.currentMinitask.packages),
      ],
    );
  }
}

Widget _packagesSection(BuildContext context, List<Package> packages) {
  final packageItems = packages
      .where((p) => p.status != PackageStatus.pending)
      .map<Widget>(_packageWidget)
      .toList();

  if (packageItems.isEmpty) {
    return Container();
  }

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Container(
        child: Text(
          Strings.orders,
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
        padding: EdgeInsets.all(2 * UI.m),
      )
    ] +
        packageItems,
  );
}

Widget _packageWidget(Package package) {
  return OrderItem(
    isMarked: false,
    recipientInitials: package.customer.initials,
    recipientName: package.customer.fullName,
    orderSummary: '',
    orderStatus: package.status.toString(),
  );
}
