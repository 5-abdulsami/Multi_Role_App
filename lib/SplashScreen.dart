import 'dart:async';

import 'package:flutter/material.dart';
import 'package:multi_role_app/HomeScreen.dart';
import 'package:multi_role_app/LoginScreen.dart';
import 'package:multi_role_app/StudentScreen.dart';
import 'package:multi_role_app/TeacherScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    isLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image(
          width: double.infinity,
          fit: BoxFit.fitWidth,
          image: AssetImage('assets/images/wallpaper.jpg')),
    );
  }

  void isLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool loginInfo = prefs.getBool('isLogin') ?? false;
    String userType = prefs.getString('userType') ?? "";

    if (loginInfo) {
      if (userType == 'student') {
        Timer(Duration(seconds: 2), () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: ((context) => StudentScreen())));
        });
      } else if (userType == "teacher") {
        Timer(Duration(seconds: 2), () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: ((context) => TeacherScreen())));
        });
      } else {
        Timer(Duration(seconds: 2), () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: ((context) => HomeScreen())));
        });
      }
    } else {
      Timer(Duration(seconds: 2), () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: ((context) => LoginScreen())));
      });
    }
  }
}
