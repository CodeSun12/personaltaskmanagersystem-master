import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:personaltaskmanagersystem/Models/friends_model.dart';
import 'package:personaltaskmanagersystem/Screens/friend_list.dart';
import '../Helper/friends_database.dart';


class AddFriendsScreen extends StatefulWidget {
  const AddFriendsScreen({Key? key}) : super(key: key);

  @override
  State<AddFriendsScreen> createState() => _AddFriendsScreenState();
}

class _AddFriendsScreenState extends State<AddFriendsScreen> {


  String selectGender = 'male';
  final formKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  DBHelper? dbHelper;


  validation(){
    if(formKey.currentState!.validate()){
      Fluttertoast.showToast(msg: "You can Add Your friend");
      print("You can add you friend");
      dbHelper?.insert(
       FriendsModel(
           fName: firstNameController.text.toString(),
           lName: lastNameController.text.toString(),
           age: int.parse(ageController.text.toString()),
           address: addressController.text.toString(),
           gender: selectGender,
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
  void initState() {
    super.initState();
    dbHelper = DBHelper();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffefd5),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.redAccent.withOpacity(0.8),
        title: const Text("Add Friends", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
        leading: IconButton(
          onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const FriendsListScreen()));
          },
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white,),
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            const SizedBox(height: 50,),
            // Padding(
            //   padding: const EdgeInsets.only(right: 18),
            //     child: GestureDetector(
            //       onTap: (){
            //         imagePicker();
            //       },
            //         child: _image == null ? Image.asset("assets/images/image.png", height: 100,) : Image.file(_image!)),
            // ),
            // const SizedBox(height: 12.0,),
            // const Padding(
            //   padding: EdgeInsets.only(left: 125.0),
            //   child: Text("Upload Image", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 19),),
            // ),
            const SizedBox(height: 40,),
            Form(
              key: formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextFormField(
                      controller: firstNameController,
                      validator: (value){
                        if(value!.isEmpty){
                          return "Please Provide Your FirstName";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          hintText: "Enter First Name",
                          hintStyle: TextStyle(color: Colors.black,),
                          labelText: "First Name",
                          labelStyle: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold),
                          border: UnderlineInputBorder(),
                          prefixIcon: Icon(Icons.person, color: Colors.black,)
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextFormField(
                      controller: lastNameController,
                        validator: (value){
                          if(value!.isEmpty){
                            return "Please Provide Your Last Name";
                          }
                          return null;
                        },
                      decoration: const InputDecoration(
                          hintText: "Enter Last Name",
                          hintStyle: TextStyle(color: Colors.black,),
                          labelText: "Last Name",
                          labelStyle: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold),
                          border: UnderlineInputBorder(),
                          prefixIcon: Icon(Icons.person, color: Colors.black,)
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextFormField(
                      controller: ageController,
                       validator: (value){
                        if(value!.isEmpty){
                          return "Please Provide Your Age";
                        }
                        return null;
                      },
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          hintText: "Enter Your Age",
                          hintStyle: TextStyle(color: Colors.black,),
                          labelText: "Age",
                          labelStyle: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold),
                          border: UnderlineInputBorder(),
                          prefixIcon: Icon(Icons.accessibility, color: Colors.black,)
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextFormField(
                      controller: addressController,
                      validator: (value){
                        if(value!.isEmpty){
                          return "Please Provide Your Address";
                        }
                        return null;
                      },
                      maxLines: 3,
                      decoration: const InputDecoration(
                          hintText: "Enter Your Address",
                          hintStyle: TextStyle(color: Colors.black,),
                          labelText: "Address",
                          labelStyle: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold),
                          border: UnderlineInputBorder(),
                          prefixIcon: Icon(Icons.location_on, color: Colors.black,)
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Padding(
                      padding: const EdgeInsets.all(25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Select Gender', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),),
                          ListTile(
                            leading: Radio<String>(
                              value: 'male',
                              groupValue: selectGender,
                              onChanged: (value) {
                                setState(() {
                                  selectGender = value!;
                                });
                              },
                              activeColor: Colors.redAccent,
                            ),
                            title: const Text('Male'),
                          ),
                          ListTile(
                            leading: Radio<String>(
                              value: 'female',
                              groupValue: selectGender,
                              onChanged: (value) {
                                setState(() {
                                  selectGender = value!;
                                });
                              },
                              activeColor: Colors.redAccent,
                            ),
                            title: const Text('Female'),
                          ),
                          const SizedBox(height: 25),
                          Text(selectGender == 'male' ? 'Hello gentlement!' : 'Hi lady!')
                        ],
                      )
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: MaterialButton(
                  color: Colors.redAccent,
                onPressed: () {
                    validation();
                },
                shape: const StadiumBorder(),
                child: const Text("Add Friend", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
              ),
            ),
            const SizedBox(height: 30,),
          ],
        ),
      ),
    );
  }
}
