import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:radom_timer/Timing.dart';

import 'TimerCard.dart';

class TimerList extends StatefulWidget {
  TimerListState createState() => TimerListState();
}

class TimerListState extends State<TimerList> {
  @override
  Widget build(BuildContext context) {

    final timingStream = Provider.of<List<Timing>>(context);

    if (timingStream != null) {
      return ListView.builder(
          itemCount: timingStream.length,
          itemBuilder: (context, index) {
            return Column(
              children: <Widget>[TimerWidget(timingStream[index])],
            );
          });
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
