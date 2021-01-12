import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:monarch_recycling/splash.dart';

import 'form.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Monarch Recycling',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   void initState() {
//     super.initState();
//     Timer(Duration(seconds: 5),
//             ()=>Navigator.pushReplacement(context,
//             MaterialPageRoute(builder:
//                 (context) =>
//                     MonarchForm()
//             )
//         )
//     );
//   }
//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     double height = MediaQuery.of(context).size.height;
//     double l = MediaQuery.of(context).size.longestSide;
//     Orientation orien = MediaQuery.of(context).orientation;
//     bool screen = orien == Orientation.portrait ? true : false;
//     return Scaffold(
//       body: SafeArea(
//         child: Container(
//             color: Colors.white,
//             child: Column(
//               children: [
//                 Padding(
//                   padding:  EdgeInsets.only(top: height/6,bottom: height/12),
//                   child: Text('MonarchRecycling',style: TextStyle(fontSize: width/10),),
//                 ),
//                 Image.asset('assets/logoRecyclingApp.png'),
//               ],
//             )
//         ),
//       ),
//     );
//   }
// }

