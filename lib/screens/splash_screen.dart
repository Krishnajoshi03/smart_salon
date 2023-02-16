import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_salon/services/splash_ser.dart';

class SplashScreen extends StatefulWidget{

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Splashser scr=Splashser();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   scr.isLogin(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text("**Firebase**",style: TextStyle(color: Colors.red,fontSize: 24,fontWeight: FontWeight.bold),))
        ],

      ),

    );
  }
}