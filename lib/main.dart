// ignore_for_file: unused_import, unused_field, use_key_in_widget_constructors
// @dart=2.9
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:listing_app/screens/login.dart';
import 'package:listing_app/screens/edit_profile_screen.dart';
import 'package:listing_app/screens/register.dart';
import 'package:listing_app/screens/settings.dart';
import 'package:listing_app/screens/welcome_screen.dart';
import 'package:listing_app/user_state.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: UserState(),
    );
  }
}

