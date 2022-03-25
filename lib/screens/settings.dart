// ignore_for_file: unused_field, prefer_const_constructors, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, prefer_final_fields, non_constant_identifier_names, unused_element, avoid_print, avoid_unnecessary_containers, sized_box_for_whitespace, avoid_types_as_parameter_names, deprecated_member_use, avoid_init_to_null, unnecessary_null_comparison, void_checks, must_call_super

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:listing_app/components/custom_account_setting_tile.dart';
import 'package:listing_app/constant.dart';
import 'package:listing_app/screens/edit_profile_screen.dart';
import 'package:listing_app/user_state.dart';
import 'package:page_transition/page_transition.dart';


class SettingScreen extends StatefulWidget { 
  final String userID;
  const SettingScreen({required this.userID});
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
   @override
  void initState(){
    super.initState();
    getUserData();
  }

  bool _isLoading = false;
  String ? username;
  String ? fullname;
  String imageUrl = " ";
  bool _isSameuser = false;
  void getUserData() async{
    _isLoading = true;
    final DocumentSnapshot userDoc = await FirebaseFirestore.instance
    .collection('registration')
    .doc(widget.userID )
    .get();
    if (userDoc == null) {
      return;
    }else {
      setState(() {
        username = userDoc.get('username');
        // fullname = userDoc.get('fullname');
      });
      _isLoading = false;
    }
  }
  @override
  Widget build(BuildContext context) {
    Size  size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.1,
        title: Text(
          "Settings",
          style: TextStyle(
            fontSize: 30,
          )
          ),
      backgroundColor: pHeadColor,
      ),
      body: _isLoading
      ?Center(child: CircularProgressIndicator()): SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                height:size.height*0.2,
                decoration:  BoxDecoration(
                    color: pHeadColor,
                  ),
                  child: Column(
                    children: [
                      h18Spacing,
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                          children: [
                          Row(
                          children: [
                            CircleAvatar(
                              child: Image.network(
                                "https://cdn.pixabay.com/photo/2014/04/02/10/25/man-303792__340.png",
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              ),
                              radius: 35.0,
                            ),
                            SizedBox(
                              width: 15.0,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Hello",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                // w10Spacing,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                     username == null ? 'name' : username!,
                                        style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                                    ),
                                    // SizedBox(width: size.width*0.4),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: CircleAvatar(
                                        backgroundColor: pHeadColor,
                                        child: IconButton(
                                          onPressed: () { 
                                             Navigator.push(
                                                context,
                                              PageTransition(
                                              type: PageTransitionType.rightToLeftJoined,
                                              childCurrent: widget,
                                              duration: Duration(milliseconds: 700),
                                              reverseDuration: Duration(milliseconds: 300),
                                              child: EditProfileScreen()),
                                             );
                                           },
                                          icon: Icon(
                                            Icons.edit
                                          ) ,
                                        ),
                                      radius: 12.0,
                                    ),
                                    )
                                  ],
                                ),
                              ],
                            )
                          ],
                  ),
                     ]
                    ),
                        )
                  )
                ],
              )
              ),
              h24Spacing,
              Column(
                children: [
                  Container(
                    child: Column(
                     children: [
                       Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: Row(
                           children: [
                             Icon(
                               Icons.person,
                               color: pHeadColor,
                             ),
                             w5Spacing,
                             Text(
                               "Account",
                               style:TextStyle(
                                 fontWeight: FontWeight.bold,
                                 fontSize: 20.0
                               )
                             )
                           ],
                         ),
                       ),
                      thickDivider(),
                      h24Spacing,
                      buildAccountTile("Change Password"),
                      buildAccountTile("App Guide"),
                      buildAccountTile("Friends"), 
                      buildAccountTile("Voucher"),
                      buildAccountTile("Refer Friend"),
                       h24Spacing,
                      Row(
                           children: [
                             Icon(
                               Icons.notification_add_sharp,
                               color: pHeadColor,
                             ),
                             w5Spacing,
                             Text(
                               "Notification",
                               style:TextStyle(
                                 fontWeight: FontWeight.bold,
                                 fontSize: 20.0
                               )
                             )
                           ],
                         ),
                        thickDivider(),
                        buildAccountTile("Customer Service"),
                        buildAccountTile("Rate Us"),
                        buildAccountTile("Report scam"),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Text(
                               "News letter",
                               style: TextStyle(
                                fontSize: 20,
                                color: Colors.black
                                )
                               ),
                               Transform.scale(
                                 scale: 0.7,
                                 child: CupertinoSwitch(
                                   activeColor: pHeadColor,
                                   value: true,
                                  onChanged: (bool val){},
                                  ),
                                 )
                           ],
                       ),
                        ),
                     ]
                    )
                  )
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 80.0),
                  child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        primary: Colors.white,
                        side: BorderSide(color: pHeadColor,),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      ),
                    onPressed: () {
                     _showLogOutDialog(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Log Out",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        )
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.logout,
                          color:pHeadColor,
                        )
                      ],
                    ),
                    ),
                ),
              )
            ],
          ), 
        ),  
      ),
    );
  }

 
 void _showLogOutDialog(context) async {
   final FirebaseAuth _auth = FirebaseAuth.instance; 
  return showDialog(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (context) {
      return AlertDialog(
        title: const Text('LogOut'),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              Text('Are you sure you want to logout'),
              // Text('$error',),
            ],
          ),
        ),
        actions: <Widget>[
           TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.canPop(context) ? Navigator.pop(context) : null;
            },
          ),
          TextButton(
            child: const Text('Yes'),
            onPressed: () {
              _auth.signOut();
              Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => UserState()
                ),(route) => false);
             },
          ),
        ],
      );
    },
  );
}
}
