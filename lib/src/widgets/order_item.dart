import 'package:flutter/material.dart';

import 'common.dart';

class OrderItem extends StatelessWidget {
  final bool isMarked;
  final String recipientInitials;
  final String recipientName;
  final String orderSummary;
  final String orderStatus;

  OrderItem(this.isMarked, this.recipientInitials, this.recipientName,
      this.orderSummary, this.orderStatus);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding:
        EdgeInsets.only(left: 2 * UI.m, right: 2 * UI.m, bottom: UI.m),
        child: Container(
          decoration: BoxDecoration(
            border: _buildBorder(),
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(2 * UI.m),
                child: _buildInitials(),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      recipientName,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      orderSummary,
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.amberAccent,
                      ),
                      child: Text(
                        orderStatus,
                        style: TextStyle(
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(UI.m),
                child: Icon(Icons.info),
              )
            ],
          ),
        ));
  }

  Border _buildBorder() => Border(
    left: BorderSide(
      width: UI.m,
      color: Colors.yellow,
    ),
    right: _buildBorderSide(),
    top: _buildBorderSide(),
    bottom: _buildBorderSide(),
  );

  Container _buildInitials() => Container(
    width: 60,
    height: 60,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: Colors.red,
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          recipientInitials,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.normal,
            fontSize: 24,
          ),
        )
      ],
    ),
  );

  BorderSide _buildBorderSide() => BorderSide(
    color: Colors.grey[300],
  );
}
