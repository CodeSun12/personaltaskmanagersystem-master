import 'package:flutter/material.dart';

class BouncyPageRoute extends PageRouteBuilder{

  final Widget widget;

  BouncyPageRoute({required this.widget})
  :super(
      transitionDuration: const Duration(milliseconds: 500),
      transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secAnimation, Widget child){

        animation = CurvedAnimation(parent: animation, curve: Curves.easeInOutSine);

        return ScaleTransition(
          scale: animation,
          alignment: Alignment.center,
          child: child,
        );
      },
      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secAnimation){
        return widget;
      }
  );
}


// Navigator.push(
// context,
// PageRouteBuilder(
// transitionDuration: Duration(seconds: 1),
// transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secAnimation, Widget child){
//
// animation = CurvedAnimation(parent: animation, curve: Curves.easeInOut);
//
// return ScaleTransition(
// scale: animation,
// alignment: Alignment.center,
// child: child,
// );
// },
// pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secAnimation){
// return FriendsListScreen();
// }
// )
// );