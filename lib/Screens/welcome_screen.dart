import 'package:flutter/material.dart';
import 'package:personaltaskmanagersystem/Widgets/animation_builder.dart';
import '../Events/screen/event_home_screen.dart';
import '../Tasks/screens/home_screen.dart';
import 'friend_list.dart';
import 'img_screen.dart';


class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffefd5),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              height: 250,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xffffefd5),
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(100)),
                // boxShadow: [
                //   BoxShadow(color: Colors.grey, offset: Offset(0.2, 0), blurRadius: 10),
                // ]
              ),
              child: Column(
                children: const [
                  Padding(
                    padding: EdgeInsets.only(top: 110.0, left: 15.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "PERSONAL ORGANIZER",
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 25,
                            letterSpacing: 1.5,
                            wordSpacing: 1.2,
                            color: Color(0xff1B1212),
                          shadows: [
                            BoxShadow(color: Colors.grey, offset: Offset(0.5, 0.5), blurRadius: 20)
                          ]
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0,),
                  Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "APP",
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 25,
                            letterSpacing: 1.5,
                            shadows: [
                              BoxShadow(color: Colors.grey, offset: Offset(0.5, 0.5), blurRadius: 20)
                            ],
                            color: Color(0xff1B1212),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,

              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, BouncyPageRoute(widget: FriendsListScreen()));

                  },
                  child: Container(
                    height: 170,
                    width: 150,
                    decoration: BoxDecoration(
                        color: Colors.redAccent.withOpacity(0.8),
                      borderRadius: const BorderRadius.only(topRight: Radius.circular(80)),
                      boxShadow: const [
                        BoxShadow(color: Colors.black45, offset: Offset(0.2, 0.2), blurRadius: 10)
                      ]
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 12.0, right: 5),
                          child: Image.asset('assets/images/fri.png', height: 100,),
                        ),
                        const SizedBox(height: 10,),
                        const Text("Add Friends", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: Colors.white),)
                      ],
                    )
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, BouncyPageRoute(widget: HomeScreen()));
                  },
                  child: Container(
                    height: 170,
                    width: 150,
                    decoration: const BoxDecoration(
                        color: Color(0xff097969),
                      borderRadius: BorderRadius.only(topRight: Radius.circular(80)),
                        boxShadow: [
                          BoxShadow(color: Colors.grey, offset: Offset(0.2, 0.2), blurRadius: 10)
                        ]
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 12.0, right: 5),
                          child: Image.asset('assets/images/tasks.png', height: 100,),
                        ),
                        const SizedBox(height: 10,),
                        const Text("Add Tasks", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),)
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,

              children: [
                GestureDetector(
                  onTap: (){
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => const EventListScreen()));
                    Navigator.push(context, BouncyPageRoute(widget: EventHomeScreen()));
                  },
                  child: Container(
                    height: 170,
                    width: 150,
                    decoration: const BoxDecoration(
                      color: Color(0xffC4B454),
                      borderRadius: BorderRadius.only(topRight: Radius.circular(80)),
                        boxShadow: [
                          BoxShadow(color: Colors.black45, offset: Offset(0.2, 0.2), blurRadius: 10)
                        ]
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0, right: 20),
                          child: Image.asset('assets/images/event.png', height: 80,),
                        ),
                        const SizedBox(height: 15,),
                        const Text("Add Events", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),)
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 170,
                  width: 150,
                  decoration: const BoxDecoration(
                    color: Color(0xff1B1212),
                    borderRadius: BorderRadius.only(topRight: Radius.circular(100)),
                      boxShadow: [
                        BoxShadow(color: Colors.grey, offset: Offset(0.2, 0.2), blurRadius: 10)
                      ]
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0, right: 15),
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(context, BouncyPageRoute(widget: ImageScreen()));
                          },
                            child: Image.asset('assets/images/image.png', height: 100,)),
                      ),
                      const SizedBox(height: 10,),
                      const Text("Add Images", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: Colors.white),)
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      )
    );
  }
}
