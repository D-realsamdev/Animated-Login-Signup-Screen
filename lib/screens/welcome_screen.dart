// ignore_for_file: unused_field, prefer_const_constructors, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, prefer_final_fields, non_constant_identifier_names, unused_element, avoid_print

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:listing_app/screens/login.dart';
import 'package:listing_app/screens/register.dart';
import 'package:listing_app/services/global_method.dart';

class WelcomeScreen extends StatefulWidget {
  
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with TickerProviderStateMixin{
  late AnimationController _animationController;
  late Animation <double> _animation;
  late TextEditingController _emailTextController = 
  TextEditingController(text: " ");
  late TextEditingController _passwordTextController = 
  TextEditingController(text: " ");

  FocusNode _emailFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();
  bool _obscureText = true;
  final _loginFormKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;


  @override
  void dispose() {
    _animationController.dispose();
    _emailTextController.dispose();
    _passwordTextController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: Duration(seconds: 20));
    _animation = CurvedAnimation(parent: _animationController, curve: Curves.linear)..addListener(() {setState(() {
      
    });
    })..addStatusListener((animationStatus) { 
      if (animationStatus == AnimationStatus.completed){
        _animationController.reset();
        _animationController.forward();
      }
    });
    _animationController.forward();
    super.initState();
  }

  void _SubmitFormLogin() async {
    final isValid = _loginFormKey.currentState!.validate();
    if(isValid){
      setState(() {
        _isLoading = true;
      });
     try{
        await _auth.signInWithEmailAndPassword(
        email: _emailTextController.text.trim().toLowerCase(),
        password: _passwordTextController.text.trim()  
      );
     }catch(errorrr){
       setState(() {
        _isLoading = false;
      });
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
      body: Stack(
        children: [
          CachedNetworkImage(
            imageUrl: "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/1200px-Image_created_with_a_mobile_phone.png",
            placeholder: (context, url) => Image.asset("assets/images/wal.png", fit:BoxFit.fill,),
            errorWidget: (context, url, error) => Icon(Icons.error),
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
            alignment: FractionalOffset(_animation.value, 0)
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListView(
              children: [
                SizedBox(
                  height:size.height*0.2,
                ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                  "Welcome",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight:FontWeight.bold
                  )
                ),
                SizedBox(
                  height: 4,
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    "Lorem Ipsum Dolor sit amet, Constetur adipscing elit, t. Ut enim ad veniam, quis nostrud exercitation ullamco attendatuer silops, andre kilsps affe.",
                    style: TextStyle(
                      color:  Colors.white,
                      fontSize: 20
                    ),
                    textAlign: TextAlign.center,
                    )
                ),
                    ],
                  ),
                  SizedBox(
                  height:size.height*0.4,
                ),
                MaterialButton(
                  color: Colors.redAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)
                    ),
                  onPressed: (){
                    Navigator.push(
                    context, MaterialPageRoute(
                    builder: (context) => LoginScreen()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Login",
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
                   SizedBox(
                  height: 10,
                ),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      primary: Colors.white,
                      side: BorderSide(color: Colors.white,),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    ),
                  onPressed: () {
                    Navigator.push(
                    context, MaterialPageRoute(
                    builder: (context) => RegisterScreen()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
                          Icons.person,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                  )
              ]
            ),
          )
        ],
      ),
    );
  }
}