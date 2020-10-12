//CREATE TIMER
//TODO: implement stream list

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:radom_timer/Styles.dart';
import 'package:radom_timer/Timing.dart';
import 'package:radom_timer/auth.dart';

class CreateTimer extends StatefulWidget {
  CreateTimerState createState() => CreateTimerState();
}

class CreateTimerState extends State<CreateTimer> {
  Timing timing = new Timing();
  AuthService _auth = new AuthService();
  User user;

  initUser() async {
    _auth = new AuthService();
    user = await _auth.currentUser();
    print("logged in");
    setState(() {});
  }

  TimerService timer;

  @override
  void initState() {
    super.initState();
    initUser();
  }

  @override
  Widget build(BuildContext context) {
    DateTime selectedDate = DateTime.now();
    timing.start = Timestamp.now();

    Future<void> _selectDate(BuildContext context) async {
      final DateTime picked = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime.now(),
          lastDate: DateTime(2101));
      if (picked != null && picked != selectedDate)
        setState(() {
          timing.time = Timestamp.fromDate(picked);
          print(timing);
        });
    }

    return Scaffold(
      backgroundColor: Styles.backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Name to be displayed",
                style: TextStyle(color: Colors.white, fontSize: 20)),
            SizedBox(
              height: 10,
            ),
            TextField(
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
              decoration:
                  Styles.kTextFieldDecoration.copyWith(hintText: "Name"),
              onChanged: (v) {
                timing.name = v;
              },
            ),
            TextField(
              decoration: Styles.kTextFieldDecoration
                  .copyWith(hintText: selectedDate.toString()),
              onTap: () => _selectDate(context),
            ),
            FlatButton(
              color: Colors.white,
              child: Text("SAVE"),
              onPressed: () {
                timer = new TimerService(user.uid);
                timer.createTimer(timing);
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
