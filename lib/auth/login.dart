import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:offsetfarm_assignment/auth/verify.dart';
import 'package:offsetfarm_assignment/wigets/customMsg.dart';
import 'package:offsetfarm_assignment/wigets/myButton.dart';

class LogInScreen extends StatefulWidget {
   LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  bool loading = false;
  final _formkey = GlobalKey<FormState>();
  final phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: _formkey,
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "A Phone number is a must";
                  }
                },
                controller: phoneNumberController,
                decoration:
                    InputDecoration(hintText: "Enter your mobile no"),
              ),
            ),
             SizedBox(
              height: 50,
            ),
            myButton(
              loading: loading,
              myheight: 50,
              mywidth: 150,
              mycolor: Colors.deepPurple,
              mytitle: "Submit",
              ontap: () {
                if (_formkey.currentState!.validate()) {
                  setState(() {
                    loading = true;
                  });
                  _loginViaPhoneNumber();
                }
              },
            )
          ],
        ),
      ),
    );
  }

  void _loginViaPhoneNumber() {
    final _auth = FirebaseAuth.instance;
    _auth.verifyPhoneNumber(
      phoneNumber: "+91${phoneNumberController.text.toString()}",
      verificationCompleted: (_) {
      
      },
      verificationFailed: (error) {
        
        CustonMsg().custonMsg(error.toString());
      },
      codeSent: (verificationId, token) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VerifyScreen(
              verificationId: verificationId,
            ),
          ),
        );
      },
      codeAutoRetrievalTimeout: (verificationId) {
        CustonMsg().custonMsg(verificationId);
      },
    );
  }
}
