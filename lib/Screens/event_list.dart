import 'package:flutter/material.dart';
import 'package:personaltaskmanagersystem/Screens/welcome_screen.dart';
import '../Widgets/add_events.dart';
import 'coming_events.dart';


class EventListScreen extends StatefulWidget {
  const EventListScreen({Key? key}) : super(key: key);

  @override
  State<EventListScreen> createState() => _EventListScreenState();
}

class _EventListScreenState extends State<EventListScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xffffefd5),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color(0xffC4B454),
          bottom: const TabBar(
            tabs: [
              Tab(text: "Coming Events",),
              Tab(text: "Past Events",),
            ],
          ),
          title: const Text("Event List", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),),
          leading: IconButton(
            onPressed: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const WelcomeScreen()));
            },
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black,),
          ),
        ),
        body: const TabBarView(
          children: [
            ComingEvents(),
            ComingEvents(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xffC4B454),
          onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AddEventsScreen()));
          },
          child: const Icon(Icons.add, size: 25, color: Colors.black,),
        ),
      ),
    );
  }
}
