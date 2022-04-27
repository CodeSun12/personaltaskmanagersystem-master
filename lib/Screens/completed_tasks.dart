import 'package:flutter/material.dart';

class CompletedTasks extends StatelessWidget {


  int? id;
  String? name, address, description;

  CompletedTasks({this.id, this.name, this.address, this.description});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffefd5),
      body: SafeArea(
        child: ListView(
          children: [
            Card(
              color: Colors.white,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(35), bottomRight: Radius.circular(35))
              ),
              child: ExpansionTile(
                collapsedTextColor: Colors.black,
                textColor: const Color(0xff097969),
                iconColor: const Color(0xff097969),
                leading: const Icon(Icons.person, color: Color(0xff097969),),
                title: Text(name ?? "Shakeeb Khan",
                  style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 17),),
                subtitle: Text(address ?? "Multan"),
                trailing: const Icon(Icons.arrow_circle_down, size: 25,),
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 13),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Description : \t\t\t ${description ?? "Hello"}",
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.w400
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5.0,),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
