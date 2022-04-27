import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:personaltaskmanagersystem/Screens/welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);


  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{


  late final AnimationController _controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this
  )..repeat();



  @override
  void dispose() {
    _controller.dispose();
    super.dispose();

  }


  void initState() {
    super.initState();

    Timer(
        Duration(seconds: 4),
            ()=> Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => WelcomeScreen())));

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:  [
            AnimatedBuilder(
                animation: _controller,
                child: Container(
                  height: 200,
                  width: 200,
                  child: Center(
                    child: Image.asset("assets/images/logo.png"),
                  ),
                ),
                builder: (BuildContext context, Widget? child){
                  return Transform.rotate(
                    angle: _controller.value * 2.0 * math.pi,
                    child: child,
                  );
                }
            ),
            SizedBox(height: MediaQuery.of(context).size.height * .02,),
            const Align(
              alignment: Alignment.center,
              child: Text(
                "Personal Organizer",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  wordSpacing: 1.5,
                  letterSpacing: 1.5,
                ),),
            )
          ],
        ),
      ),
    );
  }
}