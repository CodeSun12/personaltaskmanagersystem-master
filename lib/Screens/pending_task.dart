import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:personaltaskmanagersystem/Screens/completed_tasks.dart';

import '../Helper/task_database.dart';
import '../Models/tasks_model.dart';


class PendingTasks extends StatefulWidget {

  @override
  State<PendingTasks> createState() => _PendingTasksState();
}

class _PendingTasksState extends State<PendingTasks> {

  TextEditingController taskNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();



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
    return Scaffold(
      backgroundColor: const Color(0xffffefd5),
      body: Column(
        children: [
          const SizedBox(height: 20.0),
          Expanded(
            child: FutureBuilder(
              future: tasksList,
              builder: (context, AsyncSnapshot<List<TasksModel>> snapshot){
                if(snapshot.hasData){
                  return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index){
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Card(
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(35), bottomRight: Radius.circular(35))
                            ),
                            child: ExpansionTile(
                              collapsedTextColor: Colors.black,
                              textColor: const Color(0xff097969),
                              iconColor: const Color(0xff097969),
                              leading: const Icon(Icons.person, color: Color(0xff097969),),
                              title: Text(snapshot.data![index].taskName.toString(), style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 17),),
                              subtitle: Text(snapshot.data![index].address.toString(),),
                              trailing: const Icon(Icons.arrow_circle_down, size: 25,),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 13),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Description : \t\t\t ${snapshot.data![index].description.toString()}",
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w400
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 5.0,),
                                Row(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(left: 14),
                                      child: Text("Update Data", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),),
                                    ),
                                    const SizedBox(width: 180,),
                                    GestureDetector(
                                        onTap: (){
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context){
                                                return AlertDialog(
                                                  actions: [
                                                    TextFormField(
                                                      controller: taskNameController,
                                                      onTap: (){
                                                        setState(() {
                                                          taskNameController.text = snapshot.data![index].taskName.toString();
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
                                                          addressController.text = snapshot.data![index].address.toString();
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
                                                          descriptionController.text = snapshot.data![index].description.toString();
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
                                                      onPressed: (){
                                                        taskDBHelper?.update(
                                                            TasksModel(
                                                              id: snapshot.data![index].id!,
                                                              taskName: taskNameController.text.toString(),
                                                              address: addressController.text.toString(),
                                                              description: descriptionController.text.toString(),
                                                            )
                                                        ).then((value) {
                                                          print("Data Updated");
                                                          Fluttertoast.showToast(msg: "Data Updated Successfully");
                                                        }).onError((error, stackTrace) {
                                                          print(error.toString());
                                                        });
                                                        setState(() {
                                                          tasksList = taskDBHelper!.getTasksList();
                                                          Navigator.pop(context);
                                                        });

                                                      },
                                                      color: Colors.green,
                                                      child: Text("Update", style: TextStyle(color: Colors.white),),
                                                    )
                                                  ],
                                                );
                                              }
                                          );
                                        },
                                        child: const Icon(Icons.edit,  color: Colors.green, size: 25,))
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(left: 14),
                                      child: Text("Delete Data", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),),
                                    ),
                                    const SizedBox(width: 180,),
                                    GestureDetector(
                                        onTap: (){
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context){
                                                return AlertDialog(
                                                  content: Text("Are you sure you want to delete, if yes then press Yes"),
                                                  actions: [
                                                    SizedBox(height: 4.0,),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                      children: [
                                                        MaterialButton(
                                                          onPressed: (){
                                                            setState(() {
                                                              taskDBHelper?.delete(snapshot.data![index].id!);
                                                              // For Refreshing List
                                                              tasksList = taskDBHelper!.getTasksList();
                                                              snapshot.data!.remove(snapshot.data![index]);
                                                              Navigator.pop(context);
                                                            });
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
                                          // dbHelper!.update(
                                          //   FriendsModel(
                                          //     id: snapshot.data![index].id!,
                                          //       fName: "Wahid",
                                          //       lName: "Malik",
                                          //       age:  24,
                                          //       address: "Burewala",
                                          //       gender: "male",
                                          //   )
                                          // );
                                          // setState(() {
                                          //   friendsList = dbHelper!.getCartListWithUserId();
                                          // });
                                        },
                                        child: const Icon(Icons.delete,  color: Colors.red, size: 25,))
                                  ],
                                ),
                                const SizedBox(height: 10,),
                                MaterialButton(
                                  onPressed: (){
                                          CompletedTasks(
                                            id: snapshot.data![index].id!,
                                            name: taskNameController.text.toString(),
                                            address: addressController.text.toString(),
                                            description: descriptionController.text.toString(),
                                          );
                                  },
                                  color: const Color(0xff097969),
                                  child: const Text("Completed", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
                                ),
                                const SizedBox(height: 15,),
                              ],
                            )
                        ),
                      );
                    },
                  );
                }else{
                  return const Center(
                    child: Text("No Data Found", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}



// Dismissible(
// direction: DismissDirection.startToEnd,
// background: Container(
// color: Colors.redAccent,
// child: const Icon(Icons.delete_forever,),
// ),
// onDismissed: (DismissDirection direction){
// setState(() {
// taskDBHelper?.delete(snapshot.data![index].id!);
// // For Refreshing List
// tasksList = taskDBHelper!.getTasksList();
// snapshot.data!.remove(snapshot.data![index]);
// });
// },
// key: ValueKey<int>(snapshot.data![index].id!),
// child: Card(
// shape: const RoundedRectangleBorder(
// borderRadius: BorderRadius.only(topLeft: Radius.circular(35), bottomRight: Radius.circular(35))
// ),
// child: ExpansionTile(
// collapsedTextColor: Colors.black,
// textColor: const Color(0xff097969),
// iconColor: const Color(0xff097969),
// leading: const Icon(Icons.person, color: Color(0xff097969),),
// title: Text(snapshot.data![index].taskName.toString(), style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 17),),
// subtitle: Text(snapshot.data![index].address.toString(),),
// trailing: const Icon(Icons.arrow_circle_down, size: 25,),
// children: [
// Padding(
// padding: const EdgeInsets.only(left: 13),
// child: Align(
// alignment: Alignment.topLeft,
// child: Text(
// "Description : \t\t\t ${snapshot.data![index].description.toString()}",
// style: const TextStyle(
// color: Colors.black,
// fontSize: 17,
// fontWeight: FontWeight.w400
// ),
// ),
// ),
// ),
// const SizedBox(height: 5.0,),
// Row(
// children: [
// const Padding(
// padding: EdgeInsets.only(left: 14),
// child: Text("Update Data", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),),
// ),
// const SizedBox(width: 180,),
// GestureDetector(
// onTap: (){
// showDialog(
// context: context,
// builder: (BuildContext context){
// return AlertDialog(
// actions: [
// TextFormField(
// controller: taskNameController,
// onTap: (){
// setState(() {
// taskNameController.text = snapshot.data![index].taskName.toString();
// });
// },
// decoration: const InputDecoration(
// hintText: "Enter Task Name",
// hintStyle: TextStyle(color: Colors.black, fontSize: 15),
// labelText: "Task Name",
// labelStyle: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w800),
// prefixIcon: Icon(Icons.person, color: Colors.black,),
// ),
// ),
// TextFormField(
// controller: addressController,
// onTap: (){
// setState(() {
// addressController.text = snapshot.data![index].address.toString();
// });
// },
// decoration: const InputDecoration(
// hintText: "Enter Your Address",
// hintStyle: TextStyle(color: Colors.black, fontSize: 15),
// labelText: "Address",
// labelStyle: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w800),
// prefixIcon: Icon(Icons.location_on, color: Colors.black,),
// ),
// ),
// TextFormField(
// controller: descriptionController,
// onTap: (){
// setState(() {
// descriptionController.text = snapshot.data![index].description.toString();
// });
// },
// decoration: const InputDecoration(
// hintText: "Enter Description of Task",
// hintStyle: TextStyle(color: Colors.black, fontSize: 15),
// labelText: "Task",
// labelStyle: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w800),
// prefixIcon: Icon(Icons.description, color: Colors.black,),
// ),
// ),
// SizedBox(height: 4.0,),
// MaterialButton(
// onPressed: (){
// taskDBHelper?.update(
// TasksModel(
// id: snapshot.data![index].id!,
// taskName: taskNameController.text.toString(),
// address: addressController.text.toString(),
// description: descriptionController.text.toString(),
// )
// ).then((value) {
// print("Data Updated");
// Fluttertoast.showToast(msg: "Data Updated Successfully");
// }).onError((error, stackTrace) {
// print(error.toString());
// });
// setState(() {
// tasksList = taskDBHelper!.getTasksList();
// Navigator.pop(context);
// });
//
// },
// color: Colors.green,
// child: Text("Update", style: TextStyle(color: Colors.white),),
// )
// ],
// );
// }
// );
// },
// child: const Icon(Icons.edit,  color: Colors.green, size: 25,))
// ],
// ),
// SizedBox(height: 10),
// Row(
// children: [
// const Padding(
// padding: EdgeInsets.only(left: 14),
// child: Text("Delete Data", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),),
// ),
// const SizedBox(width: 180,),
// GestureDetector(
// onTap: (){
// showDialog(
// context: context,
// builder: (BuildContext context){
// return AlertDialog(
// content: Text("Are you sure you want to delete, if yes then press Yes"),
// actions: [
// SizedBox(height: 4.0,),
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// children: [
// MaterialButton(
// onPressed: (){
// setState(() {
// taskDBHelper?.delete(snapshot.data![index].id!);
// // For Refreshing List
// tasksList = taskDBHelper!.getTasksList();
// snapshot.data!.remove(snapshot.data![index]);
// Navigator.pop(context);
// });
// },
// color: Colors.redAccent,
// child: Text("Yes", style: TextStyle(color: Colors.white),),
// ),
// MaterialButton(
// color: Colors.green,
// onPressed: (){
// Navigator.pop(context);
// },
// child: Text("No", style: TextStyle(color: Colors.white),),
// )
// ],
// )
// ],
// );
// }
// );
// // dbHelper!.update(
// //   FriendsModel(
// //     id: snapshot.data![index].id!,
// //       fName: "Wahid",
// //       lName: "Malik",
// //       age:  24,
// //       address: "Burewala",
// //       gender: "male",
// //   )
// // );
// // setState(() {
// //   friendsList = dbHelper!.getCartListWithUserId();
// // });
// },
// child: const Icon(Icons.delete,  color: Colors.red, size: 25,))
// ],
// ),
// const SizedBox(height: 10,),
// MaterialButton(
// onPressed: (){
// setState(() {
// });
// },
// color: const Color(0xff097969),
// child: const Text("Completed", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
// ),
// const SizedBox(height: 15,),
// ],
// )
// ),
// ),