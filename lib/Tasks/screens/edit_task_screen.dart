


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personaltaskmanagersystem/Models/tasks_model.dart';
import 'package:provider/provider.dart';

import '../models/task.dart';
import '../providers/todo_model.dart';

class EditTodoView extends StatefulWidget {

  final Task task;
  final int currentIndex;



  const EditTodoView({
    Key? key,
    required this.task,
    required this.currentIndex,
  }) : super(key: key);


  @override
  _EditTodoViewState createState() => _EditTodoViewState();
}

class _EditTodoViewState extends State<EditTodoView> {
  final taskNameController = TextEditingController();
  final taskAddController = TextEditingController();
  final taskDescController = TextEditingController();

  @override
  void initState() {
    super.initState();
    taskNameController.text = widget.task.title;
    taskAddController.text = widget.task.address;
    taskDescController.text = widget.task.desc;
  }

  @override
  void dispose() {
    super.dispose();
    taskNameController.dispose();
    taskAddController.dispose();
    taskDescController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Todo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: taskNameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                hintText: 'Enter Your Task Name',
              ),
            ),
            SizedBox(height: 10,),
            TextField(
              controller: taskAddController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                hintText: 'Enter Your Address',
              ),
            ),
            SizedBox(height: 10,),
            TextField(
              controller: taskDescController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                hintText: 'Enter Task Description',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                final updatedTodo = Task(title: taskNameController.text, desc: taskDescController.text, address: taskAddController.text);
                context.read<TodosModel>().updateTodo(
                  widget.currentIndex,
                  updatedTodo,
                );

                Navigator.pop(context);
              },
              child: const Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
}