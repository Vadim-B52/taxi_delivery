import 'package:flutter/material.dart';

import 'common.dart';

class TitleDetailsCardHeader extends StatelessWidget {
  final String title;
  final String details;

  TitleDetailsCardHeader({@required this.title, @required this.details});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2 * UI.m),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Text(
              title,
              textAlign: TextAlign.start,
              style: TextStyles.textStyleSectionHeader(),
            ),
            padding: EdgeInsets.only(bottom: 0.5 * UI.m),
          ),
          Text(
            details,
            textAlign: TextAlign.start,
            style: TextStyles.textStyleRegular(),
          ),
        ],
      ),
    );
  }
}

class TitleCardHeader extends StatelessWidget {
  final String title;

  TitleCardHeader(@required this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2 * UI.m),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Text(
              title,
              textAlign: TextAlign.start,
              style: TextStyles.textStyleSectionHeader(),
            ),
            padding: EdgeInsets.only(bottom: 0.5 * UI.m),
          ),
        ],
      ),
    );
  }
}

class DetailsCardHeader extends StatelessWidget {
  final String details;

  DetailsCardHeader(@required this.details);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2 * UI.m),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            details,
            textAlign: TextAlign.start,
            style: TextStyles.textStyleRegular(),
          ),
        ],
      ),
    );
  }
}
