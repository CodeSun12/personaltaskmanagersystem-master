import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:personaltaskmanagersystem/Events/models/event.dart';
import 'package:personaltaskmanagersystem/Helper/event_helper.dart';
import 'package:personaltaskmanagersystem/Models/event_model.dart';
import 'package:provider/provider.dart';
import '../../Helper/task_database.dart';
import '../../Models/tasks_model.dart';
import '../provider/evens_model.dart';


class EventListItem extends StatefulWidget {
  final Events events;

  EventListItem({required this.events});

  @override
  State<EventListItem> createState() => _EventListItemState();
}

class _EventListItemState extends State<EventListItem> {

  TextEditingController eventNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  DateTime? date;
  final dateFormate = DateFormat('dd_MM_yyyy');



  late Future<List<EventsModel>>? eventsList;
  EventDBHelper? eventDBHelper;

  @override
  void initState() {
    super.initState();
    eventDBHelper = EventDBHelper();
  }


  loadData() async{
    eventsList = eventDBHelper!.getEventsList();
  }

  void onAdd() {
    final String textVal = eventNameController.text;
    final String textAdd = addressController.text;
    final String textTime = date.toString();
    bool completedStatus = false;
    if (textVal.isNotEmpty) {
      final Events events = Events(
          eventName: textVal,
          eventAdd: textAdd,
          time: textTime,
          completed: completedStatus,
      );
      Provider.of<EventTodosModel>(context, listen: false).addTodo(events);
      eventDBHelper?.insert(
          EventsModel(
            eventName: eventNameController.text.toString(),
              address: addressController.text.toString()
          )
      ).then((value) {
        print("Data Added");
        Fluttertoast.showToast(msg: "Data Added");
      }).onError((error, stackTrace) {
        print(error.toString());
      });
      Provider.of<EventTodosModel>(context, listen: false).deleteTodo(widget.events);
      Navigator.pop(context);
    }
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
        textColor: Color(0xffC4B454),
        iconColor: Color(0xffC4B454),
        leading: Checkbox(
          value: widget.events.completed,
          onChanged: (bool? checked) {
            Provider.of<EventTodosModel>(context, listen: false).toggleTodo(widget.events);
          },
        ),
        title: Text(widget.events.eventName, style: TextStyle(fontWeight: FontWeight.bold),),
        subtitle: Text(widget.events.eventAdd),
        trailing: const Icon(Icons.arrow_drop_down, size: 25,),
        children: [
          SizedBox(height: 5.0),
          SizedBox(height: 5.0),
          Text(widget.events.time,  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
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
                                    Provider.of<EventTodosModel>(context, listen: false).deleteTodo(widget.events);
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
                              controller: eventNameController,
                              onTap: (){
                                setState(() {
                                  eventNameController.text = widget.events.eventName;
                                });
                              },
                              decoration: const InputDecoration(
                                hintText: "Enter Event Name",
                                hintStyle: TextStyle(color: Colors.black, fontSize: 15),
                                labelText: "Event Name",
                                labelStyle: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w800),
                                prefixIcon: Icon(Icons.event, color: Colors.black,),
                              ),
                            ),
                            TextFormField(
                              controller: addressController,
                              onTap: (){
                                setState(() {
                                  addressController.text = widget.events.eventAdd;
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
                            SizedBox(height: 10,),
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

        ],
      ),
    );
  }
}



