import 'dart:math';

import 'package:flutter/material.dart';

Color inactiveColor = Color.fromRGBO(158, 158, 158, 1);

class HistoryCard extends StatelessWidget {
  String date;
  ListHistory listHistor;
  List<Widget> historys = List<Widget>();
  HistoryCard({this.date, this.listHistor});
  Icon icon;
  Color icon_color;
  @override
  Widget build(BuildContext context) {
    listHistor.list.forEach((history) {
      print(history.service);
      switch (history.service) {
        case Service.payment:
          {
            icon = Icon(Icons.receipt);
            icon_color = Colors.yellow;
            break;
          }

        case Service.receive:
          {
            icon = Icon(Icons.attach_money);
            icon_color = Colors.pinkAccent;
            break;
          }
        case Service.transfer:
          {
            icon = Icon(Icons.monetization_on);
            icon_color = Colors.redAccent;
            break;
          }
      }
      historys.add(Container(
        height: 80,
        width: MediaQuery.of(context).size.width - 40,
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: ListTile(
            leading: FloatingActionButton(
              heroTag: Random().nextInt(1000).toString(),
              child: icon,
              backgroundColor: icon_color,
            ),
            title: Text(
              history.service_name,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  fontFamily: 'Varela',
                  color: Colors.black),
            ),
            subtitle: Text(
              "${history.date_trans}    ${history.time_trans}",
              style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                  fontFamily: 'Varela',
                  color: inactiveColor),
            ),
            trailing: Text(
              "-\$ ${history.money.toString()}",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  fontFamily: 'Varela',
                  color: Colors.black),
            ),
          ),
        ),
      ));
    });

    return Wrap(
      direction: Axis.vertical,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Row(
            children: <Widget>[
              Text(
                date,
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                    fontFamily: 'Varela',
                    color: inactiveColor),
              ),
            ],
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Column(
              children: historys,
            ))
      ],
    );
  }
}

class ListHistory {
  List<History> list = new List<History>();
}

enum Service {
  transfer,
  payment,
  receive,
}

class History {
  String service_name;
  String date_trans;
  String time_trans;
  double money;
  var service = Service.payment;
  History(
      {this.service_name,
      this.money,
      this.date_trans,
      this.time_trans,
      this.service});
}
