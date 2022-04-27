import 'package:flutter/material.dart';

class Events {
  int? id;
  String eventName;
  String eventAdd;
  String time;
  bool completed;

  Events({this.id, required this.eventName, required this.eventAdd, required this.time, this.completed = false});

  void myToggleCompleted() {
    completed = !completed;
  }
}
