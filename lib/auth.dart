import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:radom_timer/Timing.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user object from response
  User _userFromResponse(User user) {
    return user != null ? user : null;
  }

  //return current user
  Future currentUser() async {
    return _auth.currentUser;
  }

  //anon
  Future signInAnon() async {
    try {
      dynamic result = await _auth.signInAnonymously();
      User user = result.user;
      return _userFromResponse(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}

// TIMERSERVICE

//create doc
class TimerService {
// collection ref
  final String uid;
  String hostId;
  CollectionReference timerCollection;

  TimerService(this.uid) {
    timerCollection = FirebaseFirestore.instance.collection(uid);
  }

  //create timer
  Future createTimer(Timing t) async {
    try {
      return await timerCollection
          .doc()
          .set({"name": t.name, "time": t.time, 'start': t.start});
    } catch (e) {
      print(e.toString());
    }
  }

  //get timers
  List<Timing> _timingsFromSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.docs
        .map((doc) => Timing(
              name: doc.data()['name'] ?? "ERROR_404",
              time: doc.data()['time'] ?? Timestamp.now(),
              start: doc.data()['start'] ?? Timestamp.now(),
            ))
        .toList();
  }

  Stream<List<Timing>> get timingStream {
    print("THIS IS THE SNAPSHOT DATA: ${timerCollection.snapshots().map(_timingsFromSnapshot)}");
    return timerCollection.snapshots().map(_timingsFromSnapshot);
  }
}
