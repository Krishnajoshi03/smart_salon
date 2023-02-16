import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_salon/screens/Dashboard.dart';
import 'package:smart_salon/screens/loginScreen.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class VerifyOtp extends StatefulWidget{
  final String verfificationId;
  const VerifyOtp({super.key,required this.verfificationId});

  @override
  State<VerifyOtp> createState() => _VerifyOtpState();
}

class _VerifyOtpState extends State<VerifyOtp> {
  String smsCode="";
  final phoneController = OtpFieldController();
  final auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(

        padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
        child: Column(
          children: [
            Form(child: Column(
              children: [
                const Text("Verification Code ",style: TextStyle(fontWeight: FontWeight.bold,fontSize:28,color: Colors.black),),
                SizedBox(height: 15,),
                Text("Enter OTP Sent to Mobile Number ",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black),),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20,0,20,0),
                  child:OtpTextField(
                    numberOfFields: 6,
                    borderColor: Color(0xFF512DA8),
                    showFieldAsBox: true,
                    handleControllers: (controllers) => phoneController,
                    //runs when a code is typed in
                    onCodeChanged: (String code) {
                      //handle validation or checks here
                      },
                    onSubmit: (String verificationCode) async {
                      smsCode=verificationCode;
                      final credential=PhoneAuthProvider.credential(verificationId: LoginScreen.verify,
                          smsCode: smsCode);
                      try{
                        await auth.signInWithCredential(credential);
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Dashboard()));
                      }
                      catch(e){
                      }
                      showDialog(
                          context: context,
                          builder: (context){
                            return AlertDialog(
                              title: Text("Verification Code"),
                              shape:OutlineInputBorder(borderRadius:BorderRadius.circular(10) ),
                              icon: Icon(Icons.numbers),
                              alignment: Alignment.center,
                              content: Text('Code entered is $verificationCode',style: TextStyle(color: Colors.black)),
                            );
                          }
                      );
                    }, // end onSubmit
                  ),
                ),
                ElevatedButton(onPressed: () async {
                  
                  if(smsCode.length<6)
                    {
                      showDialog(
                          context: context,
                          builder: (context){
                            return AlertDialog(
                              alignment: Alignment.center,
                              icon: Icon(Icons.add_alert),
                              title: Text("Verification Code Should be of 6 digit"),
                            );
                          });
                    }
                  else {
                    final credential = PhoneAuthProvider.credential(
                        verificationId: LoginScreen.verify,
                        smsCode: smsCode);
                    try {
                      await auth.signInWithCredential(credential);
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                          builder: (context) => Dashboard()), (
                          Route<dynamic> route) => false);
                    }
                    catch (e) {

                    }
                  }
                },style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.purple),fixedSize:MaterialStateProperty.all(Size(200, 30)) ), child: Center(child: Text("Submit",style: (TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18)),)))
              ],
            )

            )
          ],
        ),
      ),
    );
  }
}