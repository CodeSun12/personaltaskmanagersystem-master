import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:personaltaskmanagersystem/Helper/event_helper.dart';
import 'package:personaltaskmanagersystem/Models/event_model.dart';

class ComingEvents extends StatefulWidget {
  const ComingEvents({Key? key}) : super(key: key);

  @override
  State<ComingEvents> createState() => _ComingEventsState();
}

class _ComingEventsState extends State<ComingEvents> {


  TextEditingController eventNameController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  late Future<List<EventsModel>> eventsList;
  EventDBHelper? eventDBHelper;

  @override
  void initState() {
    super.initState();
    eventDBHelper = EventDBHelper();
    loadData();
  }

  loadData() async{
    eventsList = eventDBHelper!.getEventsList();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffefd5),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Expanded(
            child: FutureBuilder(
              future: eventsList,
              builder: (context, AsyncSnapshot<List<EventsModel>> snapshot){
                if(snapshot.hasData){
                  return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index){
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Dismissible(
                          direction: DismissDirection.startToEnd,
                          background: Container(
                            color: Colors.redAccent,
                            child: const Icon(Icons.delete_forever,),
                          ),
                          onDismissed: (DismissDirection direction){
                            setState(() {
                              eventDBHelper?.delete(snapshot.data![index].id!);
                              // For Refreshing List
                              eventsList = eventDBHelper!.getEventsList();
                              snapshot.data!.remove(snapshot.data![index]);
                            });
                          },
                          key: ValueKey<int>(snapshot.data![index].id!),
                          child: Card(
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(35), bottomRight: Radius.circular(35))
                              ),
                              child: ExpansionTile(
                                collapsedTextColor: Colors.black,
                                textColor: const Color(0xffC4B454),
                                iconColor: const Color(0xffC4B454),
                                leading: const Icon(Icons.person, color: Color(0xffC4B454),),
                                title: Text(snapshot.data![index].eventName.toString(), style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 17),),
                                subtitle: Text(snapshot.data![index].address.toString(),),
                                trailing: const Icon(Icons.arrow_circle_down, size: 25,),
                                children: [
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
                                                        controller: eventNameController,
                                                        onTap: (){
                                                          setState(() {
                                                            eventNameController.text = snapshot.data![index].eventName.toString();
                                                          });
                                                        },
                                                        decoration: const InputDecoration(
                                                          hintText: "Enter Name of Event",
                                                          hintStyle: TextStyle(color: Colors.black, fontSize: 15),
                                                          labelText: "Event Name",
                                                          labelStyle: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w800),
                                                          prefixIcon: Icon(Icons.event, color: Colors.black,),
                                                        ),
                                                      ),
                                                      TextFormField(
                                                        controller: locationController,
                                                        onTap: (){
                                                          setState(() {
                                                            locationController.text = snapshot.data![index].address.toString();
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
                                                      const SizedBox(height: 4.0,),
                                                      MaterialButton(
                                                        onPressed: (){
                                                          eventDBHelper?.update(
                                                              EventsModel(
                                                                id: snapshot.data![index].id!,
                                                                eventName: snapshot.data![index].eventName.toString(),
                                                                address: snapshot.data![index].address.toString(),
                                                              )
                                                          ).then((value) {
                                                            print("Data Updated");
                                                            Fluttertoast.showToast(msg: "Data Updated Successfully");
                                                          }).onError((error, stackTrace) {
                                                            print(error.toString());
                                                          });
                                                          setState(() {
                                                            eventsList = eventDBHelper!.getEventsList();
                                                            Navigator.pop(context);
                                                          });
                                                        },
                                                        color: Colors.green,
                                                        child: const Text("Update", style: TextStyle(color: Colors.white),),
                                                      )
                                                    ],
                                                  );
                                                }
                                            );
                                          },
                                          child: const Icon(Icons.edit,  color: Colors.green, size: 25,))
                                    ],
                                  ),
                                  const SizedBox(height: 15,),
                                ],
                              )
                          ),
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
