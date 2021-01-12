import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:monarch_recycling/form.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        splash: 'assets/logoRecyclingApp.png',
        splashIconSize: 180,
        nextScreen: MonarchForm(),
      duration: 0,
      splashTransition: SplashTransition.scaleTransition,
      animationDuration: Duration(milliseconds: 800),
    );
  }
}
