import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../strings.dart';
import 'common.dart';

class TimeSection extends StatefulWidget {
  final DateTime deliveryDate;

  TimeSection(this.deliveryDate);

  @override
  State<StatefulWidget> createState() => TimeSectionState(deliveryDate);
}

class TimeSectionState extends State<TimeSection> {
  final DateTime deliveryDate;
  Timer _timer;
  Duration _timeLeft;

  TimeSectionState(this.deliveryDate);

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    final oneSec = Duration(seconds: 1);
    updateMinutesLeft();
    _timer = Timer.periodic(
        oneSec,
            (Timer timer) => setState(() {
          updateMinutesLeft();
        }));
  }

  void updateMinutesLeft() {
    _timeLeft = deliveryDate.difference(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2 * UI.m),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Column(
            children: [
              Text(
                deliveryTimeText(),
                style: timeTextStyle(),
              ),
              Text(
                Strings.deliveryTime,
                style: detailsTextStyle(),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Text(
                '${_timeLeft.inMinutes} min',
                style: timeLeftTextStyle(),
              ),
              Text(
                Strings.timeLeft,
                style: detailsTextStyle(),
              ),
            ],
          )
        ],
      ),
    );
  }

  String deliveryTimeText() => _timeLeft.inSeconds % 2 == 0
      ? DateFormat("HH:mm").format(deliveryDate)
      : DateFormat("HH mm").format(deliveryDate);

  TextStyle timeLeftTextStyle() {
    if (deliveryDate.compareTo(DateTime.now()) > 0) {
      return timeTextStyle();
    }
    return noTimeTextStyle();
  }

  TextStyle timeTextStyle() => TextStyle(
    fontSize: 21,
    fontWeight: FontWeight.bold,
  );

  TextStyle noTimeTextStyle() => TextStyle(
    fontSize: 21,
    fontWeight: FontWeight.bold,
    color: Colors.red,
  );

  TextStyle detailsTextStyle() => TextStyle(
    fontSize: 13,
    color: Colors.grey[500],
  );
}

