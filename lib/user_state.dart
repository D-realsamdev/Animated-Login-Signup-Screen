// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:listing_app/screens/edit_profile_screen.dart';
import 'package:listing_app/screens/register.dart';
import 'package:listing_app/screens/settings.dart';

class UserState extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    // final User?  user = _auth.currentUser;
    // final String uid = user!.uid;
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (ctx,  userSnapShot){
        if (userSnapShot.data == null){
          print("user not signed in ");
          return RegisterScreen();
        }else if (userSnapShot.hasData){
          print("user signed in successfuly");
          return EditProfileScreen();
        }else if (userSnapShot.hasError){
          return Scaffold(
            body: Center(child: Text('An error occured')),
          );
        }else if (userSnapShot.connectionState == ConnectionState.waiting){
            return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        return Scaffold(
            body: Center(child: Text('something went wrong')),
          );
      });
  }
}