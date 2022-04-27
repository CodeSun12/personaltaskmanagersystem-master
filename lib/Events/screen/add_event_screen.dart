import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:personaltaskmanagersystem/Events/models/event.dart';
import 'package:provider/provider.dart';
import '../../Helper/event_helper.dart';
import '../../Helper/task_database.dart';
import '../../Models/event_model.dart';
import '../../Models/tasks_model.dart';
import '../provider/evens_model.dart';

class AddEventScreen extends StatefulWidget {
  @override
  _AddEventScreenState createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {


  final eventNameController = TextEditingController();
  final taskAddressController = TextEditingController();
  bool completedStatus = false;

  DateTime? date;
  final dateFormate = DateFormat('dd_MM_yyyy');



  EventDBHelper? eventDBHelper;

  @override
  void initState() {
    // TODO: implement initStat
    super.initState();
    eventDBHelper = EventDBHelper();
  }

  @override
  void dispose() {
    eventNameController.dispose();
    super.dispose();
  }

  void onAdd() {
    final String textVal = eventNameController.text;
    final String textAdd = taskAddressController.text;
    final String textTime = date.toString();
    final bool completed = completedStatus;
    if (textVal.isNotEmpty) {
      final Events events = Events(
        eventName: textVal,
        eventAdd: textAdd,
        time: textTime,
        completed: completed,
      );
      Provider.of<EventTodosModel>(context, listen: false).addTodo(events);
      eventDBHelper?.insert(
          EventsModel(
            eventName: eventNameController.text.toString(),
            address: taskAddressController.text.toString(),
          )
      ).then((value) {
        print("Events Added Successfully");
        Fluttertoast.showToast(msg: "Events Added Successfully");
      }).onError((error, stackTrace) {
        print(error.toString());
      });
      Navigator.pop(context);
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffC4B454),
        centerTitle: true,
        title: const Text('Add Events'),
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
                      controller: eventNameController,
                      decoration: const InputDecoration(
                        hintText: "Enter Evemt Name",
                        hintStyle: TextStyle(color: Colors.black),
                        labelText: "Event Name",
                        labelStyle: TextStyle(color: Color(0xffC4B454), fontWeight: FontWeight.bold),
                        prefixIcon: Icon(Icons.event, color: Color(0xffC4B454),),
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
                        labelStyle: TextStyle(color: Color(0xffC4B454), fontWeight: FontWeight.bold),
                        prefixIcon: Icon(Icons.location_on, color: Color(0xffC4B454),),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Text((date == null ) ? "Picked Data" : dateFormate.format(date!),  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                  const SizedBox(height: 20,),
                  MaterialButton(
                    onPressed: (){
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2023),
                      ).then((value) {
                        print(value);
                        setState(() {
                          date = value;
                        });
                      });
                    },
                    color: Colors.deepOrangeAccent,
                    shape: const StadiumBorder(),
                    child: Text("Pick Date", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                  ),
                  SizedBox(height: 15.0),
                  CheckboxListTile(
                    value: completedStatus,
                    onChanged: (checked) => setState(() {
                      completedStatus = checked!;
                    }),
                    title: const Text('Complete?'),
                  ),
                  MaterialButton(
                    color: Color(0xffC4B454),
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
