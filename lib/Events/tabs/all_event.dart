import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/evens_model.dart';
import '../widgets/event_list.dart';

class AllEventsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer<EventTodosModel>(
        builder: (context, todos, child) => EventList(events: todos.allEvents,

        ),
      ),
    );
  }
}
