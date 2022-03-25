// ignore_for_file: unused_field, prefer_const_constructors, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, prefer_final_fields, non_constant_identifier_names, unused_element, avoid_print, sized_box_for_whitespace
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:listing_app/constant.dart';
import 'package:listing_app/screens/login.dart';
import 'package:listing_app/services/global_method.dart';

class LoginScreen extends StatefulWidget {
  
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with TickerProviderStateMixin{
  late AnimationController _animationController;
  late Animation <double> _animation;
  late TextEditingController _fullnameTextController = 
  TextEditingController(text: " ");
  late TextEditingController _usernameTextController = 
  TextEditingController(text: " ");
  late TextEditingController _emailTextController = 
  TextEditingController(text: " ");
  late TextEditingController _passwordTextController = 
  TextEditingController(text: " ");
  late TextEditingController _confirmpasswordTextController = 
  TextEditingController(text: " ");

  FocusNode _usernameFocusNode = FocusNode();
  FocusNode _emailFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();
  FocusNode _confirmPasswordFocusNode = FocusNode();
  bool _obscureText = true;
  final _registerFormKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  @override
  void dispose() {
    _fullnameTextController.dispose();
    _usernameTextController.dispose();
    _emailTextController.dispose();
    _passwordTextController.dispose();
    _confirmpasswordTextController.dispose();
    _usernameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  void _SubmitFormLogin() async{
    final isValid = _registerFormKey.currentState!.validate();
    if(isValid){
      setState(() {
        _isLoading = true;
      });
     try{
        await _auth.createUserWithEmailAndPassword(
        email: _emailTextController.text.trim().toLowerCase(),
        password: _passwordTextController.text.trim()  
      );
      final User? user =_auth.currentUser;
      final _uid =user!.uid;  
      FirebaseFirestore.instance.collection('registration').doc(_uid).set({
        'id':_uid ,
        'fullname': _fullnameTextController.text,
        'username' :_usernameTextController.text,
        'email' : _emailTextController.text,
        'password' : _passwordTextController.text,
        'createdAt' : Timestamp.now(),

      });
      Navigator.canPop(context) ? Navigator.pop(context) : null;
     }catch(errorrr){
       setState(() {
        _isLoading = false;
      });
      // showErrorDialog(errorrr.toString());
       GlobalMethod.showErrorDialog(error: errorrr.toString(), context: context);
     }
    }
    setState(() {
        _isLoading = false;
      });
  }

  @override
  Widget build(BuildContext context) {
    Size  size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: textColor3,
      body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                  height:size.height*0.1,
                ),
                   Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'assets/sabi.png',
                        width: 100.0,
                        height: 100.0,
                    )
                  ), 
                  h18Spacing,
                  Text(
                    "Welcome To SabiPoint",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ), 
                  Text(
                    "A safe and secure way to transact online",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey
                    ),
                  ),
                  h18Spacing,
                  CustomTextFeild(
                    label: "Email / Username",
                    hint: "Enter Username / Username",
                  ),
                  h12Spacing,
                  CustomTextFeild(
                    label: "Password",
                    hint: "EnterPassword",
                  ), 
                h24Spacing,
                  MaterialButton(
                  color: pHeadColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35)
                    ),
                  onPressed: _SubmitFormLogin,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Sign Up",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        )
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.login,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                  ),
                  h24Spacing,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Forgot Password",
                        style: TextStyle(
                        color: pHeadColor,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        )
                      ),
                    ],
                  ),     
                ],
              ),
               )
        ),
    );
  }
}

class CustomTextFeild extends StatelessWidget {
  const CustomTextFeild({required this.label, required this.hint});

  final String label;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.grey)
          ),
          labelText: label,
          fillColor: Colors.white,
          hintText: hint
      )
    );
  }
}
