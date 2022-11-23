import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:offsetfarm_assignment/Screens/homeScreen.dart';
import 'package:offsetfarm_assignment/auth/login.dart';

class EntryService {
  void isLogin(BuildContext context) {
    final _auth = FirebaseAuth.instance;
    final _user = _auth.currentUser;

    if (_user != null) {
      
      Timer(
          const Duration(microseconds: 1),
          () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => const HomeScreen())));
    } else {
      Timer(
          const Duration(microseconds: 1),
          () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => LogInScreen())));
    }
  }
}
