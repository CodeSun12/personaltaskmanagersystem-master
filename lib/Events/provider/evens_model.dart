import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:personaltaskmanagersystem/Events/models/event.dart';


class EventTodosModel extends ChangeNotifier {
  final List<Events> _event = [];

  UnmodifiableListView<Events> get allEvents => UnmodifiableListView(_event);
  UnmodifiableListView<Events> get incompleteEvents =>
      UnmodifiableListView(_event.where((event) => !event.completed));
  UnmodifiableListView<Events> get completedEvents =>
      UnmodifiableListView(_event.where((event) => event.completed));

  void addTodo(Events event) {
    _event.add(event);
    notifyListeners();
  }

  void toggleTodo(Events event) {
    final eventIndex = _event.indexOf(event);
    _event[eventIndex].myToggleCompleted();
    notifyListeners();
  }

  void deleteTodo(Events event) {
    _event.remove(event);
    notifyListeners();
  }

  void updateTodo(int index, Events event) {
    _event[index] = event;
    notifyListeners();
  }

}
