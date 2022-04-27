import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:personaltaskmanagersystem/Helper/friends_database.dart';
import 'package:personaltaskmanagersystem/Models/friends_model.dart';
import 'package:personaltaskmanagersystem/Screens/welcome_screen.dart';
import '../Widgets/add_friends.dart';
import '../Widgets/animation_builder.dart';


class FriendsListScreen extends StatefulWidget {
  const FriendsListScreen({Key? key}) : super(key: key);

  @override
  State<FriendsListScreen> createState() => _FriendsListScreenState();
}

class _FriendsListScreenState extends State<FriendsListScreen> {


  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController addressController = TextEditingController();



  late Future<List<FriendsModel>> friendsList;
  DBHelper? dbHelper;
  String selectGender = 'male';

  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
    loadData();
  }

  loadData() async{
    friendsList = dbHelper!.getCartListWithUserId();
  }

  // Update Data




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffefd5),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.redAccent.withOpacity(0.8),
        title: const Text("Friends List", style: TextStyle(fontWeight: FontWeight.bold),),
        leading: IconButton(
          onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const WelcomeScreen()));
          },
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white,),
        ),
      ),

      body: Column(
        children: [
          SizedBox(height: 25,),
          Expanded(
            child: FutureBuilder(
              future: friendsList,
              builder: (context, AsyncSnapshot<List<FriendsModel>> snapshot){

                if(snapshot.hasData){
                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
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
                              textColor: Colors.redAccent,
                              iconColor: Colors.redAccent,
                              leading: Icon(Icons.person, color: Colors.redAccent,),
                              title: Text(snapshot.data![index].fName.toString(), style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 17),),
                              subtitle: Text(snapshot.data![index].lName.toString(),),
                              trailing: const Icon(Icons.arrow_circle_down, size: 25,),
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 13),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Age : \t\t\t ${snapshot.data![index].age.toString()}",
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w400
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5.0,),
                                Padding(
                                  padding: const EdgeInsets.only(left: 13),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Address : \t\t ${snapshot.data![index].address.toString()}",
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w400
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 5.0,),
                                Padding(
                                  padding: const EdgeInsets.only(left: 13),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Gender : \t\t ${snapshot.data![index].gender.toString()}",
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
                                                      controller: firstNameController,
                                                      onTap: (){
                                                        setState(() {
                                                          firstNameController.text = snapshot.data![index].fName.toString();
                                                        });
                                                      },
                                                      decoration: const InputDecoration(
                                                        hintText: "Enter First Name",
                                                        hintStyle: TextStyle(color: Colors.black, fontSize: 15),
                                                        labelText: "First Name",
                                                        labelStyle: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w800),
                                                        prefixIcon: Icon(Icons.person, color: Colors.black,),
                                                      ),
                                                    ),
                                                    TextFormField(
                                                      controller: lastNameController,
                                                      onTap: (){
                                                        setState(() {
                                                          lastNameController.text = snapshot.data![index].lName.toString();
                                                        });
                                                      },
                                                      decoration: const InputDecoration(
                                                        hintText: "Enter Last Name",
                                                        hintStyle: TextStyle(color: Colors.black, fontSize: 15),
                                                        labelText: "Last Name",
                                                        labelStyle: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w800),
                                                        prefixIcon: Icon(Icons.person, color: Colors.black,),
                                                      ),
                                                    ),
                                                    TextFormField(
                                                      controller: ageController,
                                                      onTap: (){
                                                        setState(() {
                                                          ageController.text = snapshot.data![index].age.toString();
                                                        });
                                                      },
                                                      decoration: const InputDecoration(
                                                        hintText: "Enter Your Age",
                                                        hintStyle: TextStyle(color: Colors.black, fontSize: 15),
                                                        labelText: "Age",
                                                        labelStyle: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w800),
                                                        prefixIcon: Icon(Icons.accessibility, color: Colors.black,),
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
                                                    SizedBox(height: 4.0,),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                      children: [
                                                        MaterialButton(
                                                          onPressed: (){
                                                            Navigator.pop(context);
                                                          },
                                                          color: Colors.redAccent,
                                                          child: Text("Back", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                                                        ),
                                                        MaterialButton(
                                                          onPressed: (){
                                                            dbHelper?.update(
                                                                FriendsModel(
                                                                  id: snapshot.data![index].id!,
                                                                  fName: firstNameController.text.toString(),
                                                                  lName: lastNameController.text.toString(),
                                                                  age: int.parse(ageController.text.toString()),
                                                                  address: addressController.text.toString(),
                                                                  gender: selectGender,
                                                                )
                                                            ).then((value) {
                                                              print("Data Updated");
                                                              Fluttertoast.showToast(msg: "Data Updated Successfully");
                                                            }).onError((error, stackTrace) {
                                                              print(error.toString());
                                                            });
                                                            setState(() {
                                                              friendsList = dbHelper!.getCartListWithUserId();
                                                              Navigator.pop(context);
                                                            });
                                                          },
                                                          color: Colors.green,
                                                          child: Text("Update", style: TextStyle(color: Colors.white),),
                                                        ),
                                                      ],
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
                                                  content: Text("Are you sure you want to delete, if yes then press delete"),
                                                  actions: [
                                                    SizedBox(height: 4.0,),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                      children: [
                                                        MaterialButton(
                                                          onPressed: (){
                                                            setState(() {
                                                              dbHelper?.delete(snapshot.data![index].id!);
                                                              // For Refreshing List
                                                              friendsList = dbHelper!.getCartListWithUserId();
                                                              snapshot.data!.remove(snapshot.data![index]);
                                                              Navigator.pop(context);
                                                            });
                                                          },
                                                          color: Colors.redAccent,
                                                          child: Text("Delete", style: TextStyle(color: Colors.white),),
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
                                const SizedBox(height: 20,),
                              ],
                            )
                        ),
                      );
                    },
                  );
                }else{
                  return Center(
                    child: Container(
                      child: const Text("No Data Found", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),)
                    ),
                  );
                }
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent.withOpacity(0.8),
        onPressed: (){
          Navigator.push(context, BouncyPageRoute(widget: AddFriendsScreen()));
        },
        child: const Icon(Icons.add, size: 25,),
      ),
    );
  }
}
