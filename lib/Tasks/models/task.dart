import 'package:flutter/material.dart';

class Task {
  int? id;
  String title;
  String address;
  String desc;
  bool completed;

  Task({this.id, required this.title, required this.address, required this.desc, this.completed = false});

  void toggleCompleted() {
    completed = !completed;
  }
}
