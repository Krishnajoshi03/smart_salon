import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_salon/screens/verifyOtp.dart';
class LoginScreen extends StatefulWidget
{
  static String verify="";
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formkey= GlobalKey<FormState>();
  final auth= FirebaseAuth.instance;
  final phoneconteoller= TextEditingController();
  bool loading=false;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        children:[
          SizedBox(height: 100),
          Text("Welcome ",style: TextStyle(color: Colors.black,fontSize: 24,fontWeight: FontWeight.bold),),
          SizedBox(height: 100,),
          Form(
            key: _formkey,
          child:Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(15, 0, 15,0 ),
                child: TextFormField(
                  keyboardType: TextInputType.phone,
                  controller: phoneconteoller,
                  decoration: InputDecoration(
                    fillColor: Colors.purple,
                    prefixIcon: Icon(CupertinoIcons.phone,color: Colors.purple),
                    labelText: "Mobile Number",
                    labelStyle: TextStyle(color: Colors.purple),
                    hintText: "Enter 10 Digit Number",
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8),borderSide: BorderSide(width: 1.5,color: Colors.purple)),
                    focusColor: Colors.yellow,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                  ),
                  validator: (value) {
                    if(value!.length!=10)
                      {
                        return" Number should be of 10 digit  ";
                      }
                  },
                ),
              ),
              SizedBox(height: 20,),
              Material(
                shape:OutlineInputBorder(borderRadius: BorderRadius.circular(8)) ,
                color: Colors.purple,
                child: InkWell(
                  splashColor: Colors.white,
                  onTap: (){
                    if(_formkey.currentState!.validate())
                      {
                        auth.verifyPhoneNumber(phoneNumber: "+91"+phoneconteoller.text,
                            verificationCompleted: (_){

                        },
                            verificationFailed: (error) {},
                            codeSent: (verificationId, forceResendingToken) {
                          LoginScreen.verify=verificationId;
                              Navigator.push(context, MaterialPageRoute(builder: (context) => VerifyOtp(verfificationId: verificationId)));
                            },
                            codeAutoRetrievalTimeout: (e){});
                      }
                  },
                  child: Container(
                    height: 40,
                    width: 300,
                    alignment: Alignment.center,
                    child: Text(
                      "Login",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.black),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
    ]
      ),
    );
  }
}