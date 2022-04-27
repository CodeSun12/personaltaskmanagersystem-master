import 'package:flutter/material.dart';
import 'package:personaltaskmanagersystem/Events/models/event.dart';
import 'package:personaltaskmanagersystem/Tasks/widgets/task_list_item.dart';

import 'event_list_item.dart';

class EventList extends StatelessWidget {
  late final List<Events> events;

  EventList({required this.events});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(vertical: 10),
      children: getChildrenEvents(),
    );
  }

  List<Widget> getChildrenEvents() {
    return events.map((eve) => EventListItem(events: eve,)).toList();
  }
}
