
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Timing.dart';


class TimerDetails extends StatefulWidget {
  Timing t;

  TimerDetails(Timing timing) {
    t = timing;
  }

  TimerDetailsState createState() => TimerDetailsState(t);
}

class TimerDetailsState extends State<TimerDetails> {
  Timing t;

  TimerDetailsState(Timing timing) {
    t = timing;
  }


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(t.name, style: TextStyle(color: Colors.white)),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(t.time.toString(), style: TextStyle(color: Colors.white))
            ],
          )
        ],
      ),
    );
  }
}
