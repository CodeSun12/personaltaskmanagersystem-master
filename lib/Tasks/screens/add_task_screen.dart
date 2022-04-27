import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../../Helper/task_database.dart';
import '../../Models/tasks_model.dart';
import '../models/task.dart';
import '../providers/todo_model.dart';

class AddTaskScreen extends StatefulWidget {
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {

  TaskDBHelper? taskDBHelper;



  final taskTitleController = TextEditingController();
  final taskAddressController = TextEditingController();
  final taskDescriptionController = TextEditingController();
  bool completedStatus = false;

  @override
  void dispose() {
    taskTitleController.dispose();
    super.dispose();
  }

  void onAdd() {
    final String textVal = taskTitleController.text;
    final String textAdd = taskAddressController.text;
    final String textDesc = taskDescriptionController.text;
    final bool completed = completedStatus;
    if (textVal.isNotEmpty) {
      final Task todo = Task(
        title: textVal,
        address: textAdd,
        desc: textDesc,
        completed: completed,
      );
      Provider.of<TodosModel>(context, listen: false).addTodo(todo);
      taskDBHelper?.insert(
          TasksModel(
            taskName: taskTitleController.text.toString(),
            address: taskAddressController.text.toString(),
            description: taskDescriptionController.text.toString(),
          )
      ).then((value) {
        print("Data Added");
        Fluttertoast.showToast(msg: "Data Added");
      }).onError((error, stackTrace) {
        print(error.toString());
      });
      Navigator.pop(context);
    }
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    taskDBHelper = TaskDBHelper();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff097969),
        centerTitle: true,
        title: const Text('Add Task'),
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(height: 70),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: TextField(
                        controller: taskTitleController,
                      decoration: const InputDecoration(
                        hintText: "Enter Task Name",
                        hintStyle: TextStyle(color: Colors.black),
                        labelText: "Task Name",
                        labelStyle: TextStyle(color: Color(0xff097969), fontWeight: FontWeight.bold),
                        prefixIcon: Icon(Icons.task_alt_outlined, color: Color(0xff097969),),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: TextField(
                        controller: taskAddressController,
                      decoration: const InputDecoration(
                        hintText: "Enter Your Location",
                        hintStyle: TextStyle(color: Colors.black),
                        labelText: "Address",
                        labelStyle: TextStyle(color: Color(0xff097969), fontWeight: FontWeight.bold),
                        prefixIcon: Icon(Icons.location_on, color: Color(0xff097969),),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: TextField(
                        controller: taskDescriptionController,
                      decoration: const InputDecoration(
                        hintText: "Enter Task Description",
                        hintStyle: TextStyle(color: Colors.black),
                        labelText: "Description",
                        labelStyle: TextStyle(color: Color(0xff097969), fontWeight: FontWeight.bold),
                        prefixIcon: Icon(Icons.description, color: Color(0xff097969),),
                      ),
                    ),
                  ),
                  CheckboxListTile(
                    value: completedStatus,
                    onChanged: (checked) => setState(() {
                      completedStatus = checked!;
                    }),
                    title: const Text('Complete?'),
                  ),
                  MaterialButton(
                    color: Color(0xff097969),
                    shape: StadiumBorder(),
                    child: const Text('Add', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                    onPressed: onAdd,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
