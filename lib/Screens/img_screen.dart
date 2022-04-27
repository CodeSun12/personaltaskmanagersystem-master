import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';


class ImageScreen extends StatefulWidget {
  const ImageScreen({Key? key}) : super(key: key);

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {


  File? _image;
  // Pick Image From Gallery
  final picker = ImagePicker();
  Future imagePicker() async{
    try{
      final pick = await picker.pickImage(source: ImageSource.gallery);
      setState(() {
        if(pick != null){
          _image = File(pick.path);
        }else{
          Fluttertoast.showToast(msg: "No Image Selected");
        }
      });
    }catch(e){
      print(e.toString());
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xff1B1212),
        title: Text("Flutter Image", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
      ),
      body: SafeArea(
        child: Container(
          height: 400,
          width: double.infinity,
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: _image == null ? Center(child: Text("No Image Selected")) : Image.file(_image!),
              ),
              MaterialButton(
                onPressed: (){
                  imagePicker();
                },
                color: Color(0xff1B1212),
                shape: StadiumBorder(),
                child: Text("Choose Image", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
              ),
            ],
          ),
        )
      ),
    );
  }
}
