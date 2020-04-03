import 'package:flutter/material.dart';

import '../widgets/common.dart';

class ParcelAcceptanceWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Приемка посылок')),
      body: ListView(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Номер посылки'
            ),
          ),
          Buttons.roundButton(context, icon: Icons.camera, title: "сканироать", onPressed: () => {}),
          Buttons.primaryButton(context, title: "Принять посылку", onPressed: () => {}),
          Buttons.secondaryButton(context, title: "Отказаться", onPressed: () => {}),
          Buttons.secondaryButton(context, title: "Больше нет посылок", onPressed: () => {}),
        ],
      ),
    );
  }

}
