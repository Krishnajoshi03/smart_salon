import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_salon/screens/loginScreen.dart';
import 'package:smart_salon/screens/splash_screen.dart';

class Splashser
{
 void isLogin(BuildContext context)
 {
  final auth=FirebaseAuth.instance;
  var user=auth.currentUser;
  Timer(const  Duration(seconds: 2), () {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
  });
 }

 }