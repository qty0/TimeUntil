import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:radom_timer/Timing.dart';
import 'package:radom_timer/auth.dart';
import 'package:radom_timer/TimerCard.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:radom_timer/Styles.dart';
import 'package:radom_timer/createTimer.dart';

import 'TimerList.dart';

//TODO: Implemet loading bar - Get creating dateó
//Dark mode better than light --> dark = dark shade of prple or blue goes well with vibrant colors

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Time Until',
      theme: ThemeData(
        primaryColor: Styles.backgroundColor,
        primarySwatch: Colors.grey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Time Until'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // ignore: deprecated_member_use
  AuthService _auth = new AuthService();
  User user;

  List<Timing> timers = [];

  Future<String> initUser() async {
    await _auth.signInAnon();
    user = await _auth.currentUser();
    print("THE UID IS ${user.uid}");
    return user.uid;
  }

  @override
  Widget build(BuildContext context) {
    //TODO: implement firebase data req
    return FutureBuilder<String>(
        future: initUser(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return StreamProvider<List<Timing>>.value(
              value: TimerService(snapshot.data).timingStream,
              child: Scaffold(
                backgroundColor: Styles.backgroundColor,
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => CreateTimer()));
                  },
                  child: Icon(Icons.add),
                ),
                appBar: AppBar(
                  elevation: 0.1,
                  backgroundColor: Styles.backgroundColor,
                  centerTitle: true,
                  title: Text(widget.title),
                  actions: <Widget>[
                    IconButton(
                      icon: Icon(Icons.list),
                      onPressed: () {
                        //TODO
                      },
                    )
                  ],
                ),
                body: TimerList()
              ),
            );
          } else {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
