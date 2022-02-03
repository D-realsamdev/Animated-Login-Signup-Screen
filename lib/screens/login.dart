// ignore_for_file: unused_field, prefer_const_constructors, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, prefer_final_fields, non_constant_identifier_names, unused_element, avoid_print

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:listing_app/screens/register.dart';

class LoginScreen extends StatefulWidget {
  
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with TickerProviderStateMixin{
  late AnimationController _animationController;
  late Animation <double> _animation;
  late TextEditingController _emailTextController = 
  TextEditingController(text: " ");
  late TextEditingController _passwordTextController = 
  TextEditingController(text: " ");
  bool _obscureText = true;
  final _loginFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _animationController.dispose();
    _emailTextController.dispose();
    _passwordTextController.dispose();
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

  void _SubmitFormLogin(){
    final isValid = _loginFormKey.currentState!.validate();
    print(';isValid $isValid');
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
                  height:size.height*0.1,
                ),
                Text(
                  "Login",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight:FontWeight.bold
                  )
                ),
                SizedBox(
                  height: 4,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Dont have an account',
                      ),
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Navigator.push(
                            context, MaterialPageRoute(
                              builder: (context) => RegisterScreen())),
                        text: '   Register',
                        style: TextStyle(color: Colors.red )
                      )
                    ]
                  )
                  ),
                  SizedBox(height: 30),
                  Form(
                    key: _loginFormKey,
                    child: Column(
                      children: [
                        TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailTextController,
                    validator: (value){
                      if(value!.isEmpty){
                        return "Please enter your valid email address";
                      }if(value.contains("@")){
                        return "Please enter a valid email address";
                      }
                      else{
                        return null;
                      }
                    },
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                       labelText: "Email",
                      labelStyle: TextStyle(color: Colors.white,
                      fontSize: 20
                      ),
                      enabledBorder:UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                      ),
                      errorBorder:UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ) 
                    )
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    obscureText: _obscureText,
                    keyboardType: TextInputType.visiblePassword,
                    controller: _passwordTextController,
                    validator: (value){
                      if(value!.isEmpty || value.length < 6){
                        return "Please enter a password";
                      }if(value.length > 10){
                        return "Password too long";
                      }
                      else{
                        return null;
                      }
                    },
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                        onTap: (){
                          setState(() {
                            _obscureText =! _obscureText;
                          });
                        },
                        child: Icon(
                           _obscureText ?Icons.visibility : Icons.visibility_off,
                            color: Colors.white
                          ),
                      ),
                      labelText: "Password",
                      labelStyle: TextStyle(color: Colors.white,
                      fontSize: 20,),
                      enabledBorder:UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                      ),
                      errorBorder:UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ) 
                    )
                  ),
                      ],
                    )
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {}, 
                        child: Text(
                          "Forgot Password",
                        style:TextStyle(
                          color: Colors.red,
                          fontSize: 15,
                        ),  
                        ), 
                      ),
                    ],
                  ), 
                  SizedBox(
                    height: 20,
                  ),
                MaterialButton(
                  color: Colors.redAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)
                    ),
                  onPressed: _SubmitFormLogin,
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
                  )
              ]
            ),
          )
        ],
      ),
    );
  }
}