import 'package:flutter/material.dart';
import 'package:personaltaskmanagersystem/Screens/completed_tasks.dart';
import 'package:personaltaskmanagersystem/Screens/pending_task.dart';
import 'package:personaltaskmanagersystem/Screens/welcome_screen.dart';

import '../Widgets/add_friends.dart';
import '../Widgets/add_task.dart';


class TaskListScreen extends StatefulWidget {
  const TaskListScreen({Key? key}) : super(key: key);

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> with SingleTickerProviderStateMixin{


  TabController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffefd5),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xff097969),
        bottom:  TabBar(
          controller: _controller,
          tabs: [
            Tab(text: "Pending Tasks",),
            Tab(text: "Completed Tasks",),
          ],
        ),
        title: const Text("Tasks List", style: TextStyle(fontWeight: FontWeight.bold),),
        leading: IconButton(onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const WelcomeScreen()));
        }, icon: const Icon(Icons.arrow_back_ios, color: Colors.white,)),
      ),

      body: TabBarView(
        controller: _controller,
        children: [
          PendingTasks(),
          CompletedTasks(),
        ],
      ),


      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff097969),
        onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AddTaskScreen()));
        },
        child: const Icon(Icons.add, size: 25,),
      ),
    );
  }
}
