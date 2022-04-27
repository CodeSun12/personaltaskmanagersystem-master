import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:personaltaskmanagersystem/Helper/event_helper.dart';
import 'package:personaltaskmanagersystem/Screens/event_list.dart';
import 'package:personaltaskmanagersystem/Screens/task_list.dart';

import '../Models/event_model.dart';

class AddEventsScreen extends StatefulWidget {
  const AddEventsScreen({Key? key}) : super(key: key);

  @override
  State<AddEventsScreen> createState() => _AddEventsScreenState();
}

class _AddEventsScreenState extends State<AddEventsScreen> {

  // DateTime? _dateTime;

  TextEditingController eventNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  EventDBHelper? eventDBHelper;

  @override
  void initState() {
    // TODO: implement initStat
    super.initState();
    eventDBHelper = EventDBHelper();
  }

  // Validation Function
  validation(){
    if(formKey.currentState!.validate()){
      Fluttertoast.showToast(msg: "You can Add Your Event");
      print("You can add Event");
      eventDBHelper?.insert(
          EventsModel(
            eventName: eventNameController.text.toString(),
            address: addressController.text.toString(),
          )
      ).then((value) {
        print("Events Added Successfully");
        Fluttertoast.showToast(msg: "Events Added Successfully");
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
        backgroundColor: const Color(0xffC4B454),
        title: const Text("Add Events", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
        leading: IconButton(
          onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const EventListScreen()));
          },
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black,),
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
                      controller: eventNameController,
                      validator: (value){
                        if(value!.isEmpty){
                          return "Please Provide Event";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          hintText: "Enter Your Event",
                          hintStyle: TextStyle(color: Colors.black,),
                          labelText: "Event",
                          labelStyle: TextStyle(color: Color(0xffC4B454), fontWeight: FontWeight.bold),
                          border: UnderlineInputBorder(),
                          prefixIcon: Icon(Icons.event, color: Colors.black,)
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
                          return "Please Provide Address";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          hintText: "Enter Your Location",
                          hintStyle: TextStyle(color: Colors.black,),
                          labelText: "Location",
                          labelStyle: TextStyle(color: Color(0xffC4B454), fontWeight: FontWeight.bold),
                          border: UnderlineInputBorder(),
                          prefixIcon: Icon(Icons.description, color: Colors.black,)
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0,),
                  // Column(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: <Widget>[
                  //     Text(_dateTime == null ? 'Nothing has been picked yet' : _dateTime.toString()),
                  //     const SizedBox(height: 10,),
                  //     MaterialButton(
                  //       color: const Color(0xffC4B454),
                  //       shape: const StadiumBorder(),
                  //       child: const Text('Pick a date', style: TextStyle(fontWeight: FontWeight.bold),),
                  //       onPressed: () {
                  //         showDatePicker(
                  //           context: context,
                  //           initialDate: DateTime.now(),
                  //           firstDate: DateTime(2001),
                  //           lastDate: DateTime(2030),
                  //         ).then((date) {
                  //           setState(() {
                  //             _dateTime = date;
                  //           });
                  //         });
                  //       },
                  //     )
                  //   ],
                  // ),
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
                color: const Color(0xffC4B454),
                shape: const StadiumBorder(),
                child: const Text("Add Event", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
