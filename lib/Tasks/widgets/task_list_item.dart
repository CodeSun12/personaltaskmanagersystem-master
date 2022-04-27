import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../Helper/task_database.dart';
import '../../Models/tasks_model.dart';
import '../models/task.dart';
import '../providers/todo_model.dart';
import '../screens/edit_task_screen.dart';

class TaskListItem extends StatefulWidget {
  final Task task;
  final int? currentIndex;

  TaskListItem({required this.task, this.currentIndex});

  @override
  State<TaskListItem> createState() => _TaskListItemState();
}

class _TaskListItemState extends State<TaskListItem> {

  TextEditingController taskNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();


  void onAdd() {
    final String textVal =  taskNameController.text;
    final String textAdd = addressController.text;
    final String textDesc = descriptionController.text;
    if (textVal.isNotEmpty) {
      final Task todo = Task(
        title: textVal,
        address: textAdd,
        desc: textDesc,
      );
      Provider.of<TodosModel>(context, listen: false).addTodo(todo);
      taskDBHelper?.insert(
          TasksModel(
            taskName: taskNameController.text.toString(),
            address: addressController.text.toString(),
            description: descriptionController.text.toString(),
          )
      ).then((value) {
        print("Data Added");
        Fluttertoast.showToast(msg: "Data Added");
      }).onError((error, stackTrace) {
        print(error.toString());
      });
      Provider.of<TodosModel>(context, listen: false).deleteTodo(widget.task);
      Navigator.pop(context);
    }
  }



  late Future<List<TasksModel>> tasksList;

  TaskDBHelper? taskDBHelper;

  @override
  void initState() {
    super.initState();
    taskDBHelper = TaskDBHelper();
    loadData();
  }

  loadData() async{
    tasksList = taskDBHelper!.getTasksList();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(35), bottomRight: Radius.circular(35))
      ),
      child: ExpansionTile(
        collapsedTextColor: Colors.black,
        textColor: const Color(0xff097969),
        iconColor: const Color(0xff097969),
        leading: Checkbox(
          value: widget.task.completed,
          onChanged: (bool? checked) {
            Provider.of<TodosModel>(context, listen: false).toggleTodo(widget.task);
          },
        ),
        title: Text(widget.task.title, style: TextStyle(fontWeight: FontWeight.bold),),
        subtitle: Text(widget.task.desc),
        trailing: const Icon(Icons.arrow_drop_down, size: 25,),
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 65),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Description : \t\t\t ${widget.task.desc}",
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.w400
                ),
              ),
            ),
          ),
          SizedBox(height: 5.0),
          SizedBox(height: 5.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: (){
                  showDialog(
                      context: context,
                      builder: (BuildContext context){
                        return AlertDialog(
                          content: Text("Are you sure you want to delete, if yes then press delete"),
                          actions: [
                            SizedBox(height: 4.0,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                MaterialButton(
                                  onPressed: (){
                                    Provider.of<TodosModel>(context, listen: false).deleteTodo(widget.task);
                                    Navigator.pop(context);
                                  },
                                  color: Colors.redAccent,
                                  child: Text("Yes", style: TextStyle(color: Colors.white),),
                                ),
                                MaterialButton(
                                  color: Colors.green,
                                  onPressed: (){
                                    Navigator.pop(context);
                                  },
                                  child: Text("No", style: TextStyle(color: Colors.white),),
                                )
                              ],
                            )
                          ],
                        );
                      }
                  );
                },
                icon: const Icon(Icons.delete, color: Colors.redAccent, size: 30,),
              ),
              IconButton(
                onPressed: (){
                  showDialog(
                      context: context,
                      builder: (BuildContext context){
                        return AlertDialog(
                          actions: [
                            TextFormField(
                              controller: taskNameController,
                              onTap: (){
                                setState(() {
                                  taskNameController.text = widget.task.title;
                                });
                              },
                              decoration: const InputDecoration(
                                hintText: "Enter Task Name",
                                hintStyle: TextStyle(color: Colors.black, fontSize: 15),
                                labelText: "Task Name",
                                labelStyle: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w800),
                                prefixIcon: Icon(Icons.person, color: Colors.black,),
                              ),
                            ),
                            TextFormField(
                              controller: addressController,
                              onTap: (){
                                setState(() {
                                  addressController.text = widget.task.address;
                                });
                              },
                              decoration: const InputDecoration(
                                hintText: "Enter Your Address",
                                hintStyle: TextStyle(color: Colors.black, fontSize: 15),
                                labelText: "Address",
                                labelStyle: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w800),
                                prefixIcon: Icon(Icons.location_on, color: Colors.black,),
                              ),
                            ),
                            TextFormField(
                              controller: descriptionController,
                              onTap: (){
                                setState(() {
                                  descriptionController.text = widget.task.desc;
                                });
                              },
                              decoration: const InputDecoration(
                                hintText: "Enter Description of Task",
                                hintStyle: TextStyle(color: Colors.black, fontSize: 15),
                                labelText: "Task",
                                labelStyle: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w800),
                                prefixIcon: Icon(Icons.description, color: Colors.black,),
                              ),
                            ),
                            SizedBox(height: 4.0,),
                            MaterialButton(
                              onPressed: onAdd,
                              color: Colors.green,
                              shape: StadiumBorder(),
                              child: Text("Update", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
                            )
                          ],
                        );
                      }
                  );
                },
                icon: const Icon(Icons.edit, color: Colors.green, size: 30,),
              ),

            ],
          ),

          // Row(
          //   children: [
          //     const Padding(
          //       padding: EdgeInsets.only(left: 14),
          //       child: Text("Update Data", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),),
          //     ),
          //     const SizedBox(width: 180,),
          //     GestureDetector(
          //         onTap: (){
          //           showDialog(
          //               context: context,
          //               builder: (BuildContext context){
          //                 return AlertDialog(
          //                   actions: [
          //                     TextFormField(
          //                       controller: taskNameController,
          //                       onTap: (){
          //                         setState(() {
          //                           taskNameController.text = widget.task.title;
          //                         });
          //                       },
          //                       decoration: const InputDecoration(
          //                         hintText: "Enter Task Name",
          //                         hintStyle: TextStyle(color: Colors.black, fontSize: 15),
          //                         labelText: "Task Name",
          //                         labelStyle: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w800),
          //                         prefixIcon: Icon(Icons.person, color: Colors.black,),
          //                       ),
          //                     ),
          //                     TextFormField(
          //                       controller: addressController,
          //                       onTap: (){
          //                         setState(() {
          //                           addressController.text = widget.task.address;
          //                         });
          //                       },
          //                       decoration: const InputDecoration(
          //                         hintText: "Enter Your Address",
          //                         hintStyle: TextStyle(color: Colors.black, fontSize: 15),
          //                         labelText: "Address",
          //                         labelStyle: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w800),
          //                         prefixIcon: Icon(Icons.location_on, color: Colors.black,),
          //                       ),
          //                     ),
          //                     TextFormField(
          //                       controller: descriptionController,
          //                       onTap: (){
          //                         setState(() {
          //                           descriptionController.text = widget.task.desc;
          //                         });
          //                       },
          //                       decoration: const InputDecoration(
          //                         hintText: "Enter Description of Task",
          //                         hintStyle: TextStyle(color: Colors.black, fontSize: 15),
          //                         labelText: "Task",
          //                         labelStyle: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w800),
          //                         prefixIcon: Icon(Icons.description, color: Colors.black,),
          //                       ),
          //                     ),
          //                     SizedBox(height: 4.0,),
          //                     MaterialButton(
          //                       onPressed: (){
          //                         taskDBHelper?.update(
          //                             TasksModel(
          //                               id: widget.task.id,
          //                               taskName: taskNameController.text.toString(),
          //                               address: addressController.text.toString(),
          //                               description: descriptionController.text.toString(),
          //                             )
          //                         ).then((value) {
          //                           print("Data Updated");
          //                           Fluttertoast.showToast(msg: "Data Updated Successfully");
          //                         }).onError((error, stackTrace) {
          //                           print(error.toString());
          //                         });
          //                         setState(() {
          //                           tasksList = taskDBHelper!.getTasksList();
          //                           Navigator.pop(context);
          //                         });
          //
          //                       },
          //                       color: Colors.green,
          //                       child: Text("Update", style: TextStyle(color: Colors.white),),
          //                     )
          //                   ],
          //                 );
          //               }
          //           );
          //         },
          //         child: const Icon(Icons.edit,  color: Colors.green, size: 25,))
          //   ],
          // ),

        ],
      ),
    );
  }
}



