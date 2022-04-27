import 'package:flutter/material.dart';
import 'package:personaltaskmanagersystem/Events/screen/add_event_screen.dart';

import '../tabs/all_event.dart';
import '../tabs/coming_events.dart';
import '../tabs/past_events.dart';


class EventHomeScreen extends StatefulWidget {
  @override
  _EventHomeScreenState createState() => _EventHomeScreenState();
}

class _EventHomeScreenState extends State<EventHomeScreen>
    with SingleTickerProviderStateMixin {
  TabController? controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffefd5),
      appBar: AppBar(
        backgroundColor: Color(0xffC4B454),
        centerTitle: true,
        title: const Text('Event List', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddEventScreen(),
                ),
              );
            },
          ),
        ],
        bottom: TabBar(
          controller: controller,
          tabs: const <Widget>[
            Tab(text: 'All'),
            Tab(text: 'Coming'),
            Tab(text: 'Past'),
          ],
        ),
      ),
      body: TabBarView(
        controller: controller,
        children: <Widget>[
          AllEventsTab(),
          ComingEventsTab(),
          PastEventsTab(),
        ],
      ),
    );
  }
}
