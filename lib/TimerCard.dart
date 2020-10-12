import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:radom_timer/Styles.dart';
import 'package:radom_timer/TimerDetails.dart';
import 'package:radom_timer/Timing.dart';

class TimerWidget extends StatefulWidget {
  Timing t;

  TimerWidget(timing) {
    t = timing;
  }

  TimerWidgetState createState() => TimerWidgetState(t);
}

class TimerWidgetState extends State<TimerWidget> {
  Timing t;

  TimerWidgetState(Timing timing) {
    t = timing;
  }

  @override
  Widget build(BuildContext context) {
    int _timeleft = ((t.time.millisecondsSinceEpoch - DateTime.now().millisecondsSinceEpoch));

    int _timeleftDays() {
      return (_timeleft ~/ 86400000);
    }

    Color _howLong() {
      print(_timeleftDays().toString());
      if (_timeleftDays() > 365 / 2) {
        return Colors.redAccent;
      } else if (_timeleftDays() > 365 / 4) {
        return Colors.orangeAccent;
      } else if (_timeleftDays() > 365 / 6) {
        return Colors.yellowAccent;
      } else if (_timeleftDays() < 30 && _timeleftDays() != 0) {
        return Colors.greenAccent;
      } else {
        return Colors.cyanAccent;
      }
    }

    String _howfar() {
      if (_timeleftDays() > 365 / 2) {
        return " More than half a year";
      } else if (_timeleftDays() > 365 / 4) {
        return " More than three months";
      } else if (_timeleftDays() > 365 / 6) {
        return " More than two months";
      } else if (_timeleftDays() < 30 && _timeleftDays() != 0) {
        return " Less then a month";
      } else {
        return " The past is mysterious";
      }

    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => TimerDetails(t)));
      },
      child: Card(
        elevation: 8.0,
        margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        child: Container(
            decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
            child: ListTile(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                leading: Container(
                  padding: EdgeInsets.only(right: 12.0),
                  decoration: new BoxDecoration(
                      border: new Border(
                          right: new BorderSide(
                              width: 1.0, color: Colors.white24))),
                  child: Icon(Icons.font_download, color: Colors.white),
                ),
                title: Text(
                  t.name,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                subtitle: Row(
                  children: <Widget>[
                    Icon(Icons.linear_scale, color: _howLong()),
                    Text(_howfar(), style: TextStyle(color: Colors.white))
                  ],
                ),
                trailing: Icon(Icons.keyboard_arrow_right,
                    color: Colors.white, size: 30.0))),
      ),
    );
  }
}
