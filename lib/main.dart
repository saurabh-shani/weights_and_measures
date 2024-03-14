import 'package:flutter/material.dart';
import 'package:weights/screens/compalint_screen.dart';
import 'package:weights/screens/complaint_detail_screen.dart';
import 'package:weights/screens/dash_board_screen.dart';
import 'package:weights/screens/departmental_login_screen.dart';
import 'package:weights/screens/login_screen.dart';
import 'package:weights/screens/splash_screen.dart';
import 'package:weights/screens/try_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
      routes: {
        ComplaintScreen.routeName: (ctx) => ComplaintScreen(),
        ComplaintDetailsScreen.routeName: (ctx) => ComplaintDetailsScreen(),
        LoginScreen.routeName: (ctx) => LoginScreen(),
        DepartmentalLoginScreen.routeName: (ctx) => DepartmentalLoginScreen(),
        DashBoaredScreen.routeName: (ctx) => DashBoaredScreen(),
        TryScreen.routeName: (ctx) => TryScreen(),
      },
    );
  }
}
