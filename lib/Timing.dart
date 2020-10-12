
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Timing {
  Timestamp time;
  Timestamp start;
  String name;

  Timing({Key key, this.time, this.name,this.start});
}
