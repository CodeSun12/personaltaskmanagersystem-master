import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:personaltaskmanagersystem/Helper/task_database.dart';
import 'package:personaltaskmanagersystem/Models/tasks_model.dart';
import 'package:personaltaskmanagersystem/Screens/task_list.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {

  TextEditingController taskNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  TaskDBHelper? taskDBHelper;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    taskDBHelper = TaskDBHelper();
  }

  // Validation Function
  validation(){
    if(formKey.currentState!.validate()){
      Fluttertoast.showToast(msg: "You can Add Your Task");
      print("You can add Tasks");
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
    }else{
      Fluttertoast.showToast(msg: 'Please Provide the required information');
      print("Enter The Information in the Textfields");
    }
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffefd5),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xff097969),
        title: const Text("Add Tasks", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
        leading: IconButton(
          onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const TaskListScreen()));
          },
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white,),
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            const SizedBox(height: 90.0,),
            Form(
              key: formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: TextFormField(
                      controller: taskNameController,
                      validator: (value){
                        if(value!.isEmpty){
                          return "Please Provide Your Task Name";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          hintText: "Enter Your Task Name",
                          hintStyle: TextStyle(color: Colors.black,),
                          labelText: "Task Name",
                          labelStyle: TextStyle(color: Color(0xff097969), fontWeight: FontWeight.bold),
                          border: UnderlineInputBorder(),
                          prefixIcon: Icon(Icons.task_alt_outlined, color: Colors.black,)
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: TextFormField(
                      controller: addressController,
                      validator: (value){
                        if(value!.isEmpty){
                          return "Please Provide Your Address";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          hintText: "Enter Your Location",
                          hintStyle: TextStyle(color: Colors.black,),
                          labelText: "Address",
                          labelStyle: TextStyle(color: Color(0xff097969), fontWeight: FontWeight.bold),
                          border: UnderlineInputBorder(),
                          prefixIcon: Icon(Icons.description, color: Colors.black,)
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: TextFormField(
                      controller: descriptionController,
                      validator: (value){
                        if(value!.isEmpty){
                          return "Please Provide Description";
                        }
                        return null;
                      },
                      maxLines: 3,
                      decoration: const InputDecoration(
                          hintText: "Enter Description",
                          hintStyle: TextStyle(color: Colors.black,),
                          labelText: "Description",
                          labelStyle: TextStyle(color: Color(0xff097969), fontWeight: FontWeight.bold),
                          border: UnderlineInputBorder(),
                          prefixIcon: Icon(Icons.description, color: Colors.black,)
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 35,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: MaterialButton(
                onPressed: (){
                  validation();
                },
                color: const Color(0xff097969),
                shape: const StadiumBorder(),
                child: const Text("Add Task", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
