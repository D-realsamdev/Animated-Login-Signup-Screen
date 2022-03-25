// ignore_for_file: unused_field, prefer_const_constructors, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, prefer_final_fields, non_constant_identifier_names, unused_element, avoid_print, avoid_unnecessary_containers, sized_box_for_whitespace, avoid_types_as_parameter_names, deprecated_member_use, avoid_init_to_null, unnecessary_null_comparison, void_checks
import 'dart:io';
import 'dart:io' as io;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:listing_app/components/userinfo.dart';
import 'package:listing_app/constant.dart';
import 'package:listing_app/screens/settings.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sliding_sheet/sliding_sheet.dart';


class EditProfileScreen extends StatefulWidget { 
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  // PickedFile? imageFile = null;
  // List<PickedFile>? _imageFile;
   PickedFile? _imageFile;
  // File ? imageFile;

  final ImagePicker _picker = ImagePicker();

  Future uploadImageToFirebase(context) async {
    String fileName = basename(_imageFile!.path);
    firebase_storage.Reference ref =
    firebase_storage.FirebaseStorage.instance
        .ref().child('uploads').child('/$fileName');

    final metadata = firebase_storage.SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'picked-file-path': fileName});
    firebase_storage.UploadTask uploadTask;
    //late StorageUploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
    uploadTask = ref.putFile(io.File(_imageFile!.path), metadata);

    firebase_storage.UploadTask task= await Future.value(uploadTask);
    Future.value(uploadTask).then((value) => {
    print("Upload file path ${value.ref.fullPath}")
    }).onError((error, stackTrace) => {
      print("Upload file path error ${error.toString()} ")
    });



  }


  @override
  Widget build(BuildContext context) {
     final FirebaseAuth _auth = FirebaseAuth.instance;
    final User?  user = _auth.currentUser;
    final String uid = user!.uid;
    Size  size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.1,
        title: Text(
          "Edit Profile"
          ),
          centerTitle: true,
        leading: IconButton(onPressed: () { 
          Navigator.pop(context);
         },
        icon: Icon(Icons.arrow_back)),
        actions: [
          IconButton(
            // onPressed: () {
            //   _navigateToSettingScreen;
            //  },
            onPressed: () { 
                                             Navigator.push(
                                                context,
                                              PageTransition(
                                              type: PageTransitionType.rightToLeftJoined,
                                              childCurrent: widget,
                                              duration: Duration(milliseconds: 700),
                                              reverseDuration: Duration(milliseconds: 300),
                                              child: SettingScreen(userID: uid,)),
                                             );
                                           },
            icon: Icon(Icons.settings)
          )
        ],
      backgroundColor: pHeadColor,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                height:size.height*0.3,
                decoration:  BoxDecoration(
                    color: pHeadColor,
                  ),
                  child: Column(
                    children: [
                      h24Spacing,
                      Profileimage(),
                    ],
                  ),
              ),
              h24Spacing,
              Column(
                children: [
                  Container(
                    child: Column(
                     children: [
                      // UserInfo(
                      //   icon: Icons.person,
                      //   userText: "Mark Josey",
                      // ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right:20,),
                        child: Column(
                          children: [
                            CustomTextField(
                              labelText: "Username",
                              onChanged: (String ) {  },
                            ),
                            CustomTextField(
                              labelText: "Email",
                              onChanged: (String ) {  },
                            ),
                            CustomTextField(
                              labelText: "Phone",
                              onChanged: (String ) {  },
                            ),
                            CustomTextField(
                              labelText: "Gender",
                              onChanged: (String ) {  },
                            ),
                          ],
                        )
                        
                      ),
                      h24Spacing,
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
                     uploadImageToFirebase(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Save Changes",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        )
                        ),
                      ],
                    ),
                    ),
                ),
              )
                     ]
                    ),
                  )
                ],
              )
            ],
          ), 
        ),  
      ),
    );
  }
Widget Profileimage(){
  return Center(
    child: Stack(
      children: [
        InkWell(
              onTap: (){
                showSheet(context);
              },
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 65.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child:  ( _imageFile==null)? Image.network(
                  "https://cdn.pixabay.com/photo/2014/04/02/10/25/man-303792__340.png",
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ): Image.file( File(  _imageFile!.path)),
              )
          ),
        ),
        Positioned(
          bottom: 8,
          right: 15,
          child: CircleAvatar( 
            backgroundColor: Colors.white,
            radius: 13.0,
            child: Icon(
              Icons.camera_alt
            ),
          ),
        )
      ]
    ),
  );
}

Future  showSheet(context) => showSlidingBottomSheet(
   context,
  builder: (context) => SlidingSheetDialog(
    cornerRadius: 16,
    snapSpec: SnapSpec(
      snappings: [0.7],
    ),
    builder: buildSheet,
    headerBuilder: buildHeader,
  ),
);

Widget buildSheet(context, state) =>Material(
  child: Column(
    children: [
     Container(
        //  height: MediaQuery.of(context).size.height * 0.95,
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Add Profile Image",
                  style: TextStyle(
                   fontSize: 20 
                  ),
                  ),
              ),
              h18Spacing,
              InkWell(
                onTap: (){getFromCamera(ImageSource.camera);},
                child: UploadDialogInfo(
                  icon: Icons.photo_camera,
                  userText: "Take a Photo"
                ),
              ),
              h24Spacing,
              InkWell(
                onTap: (){getFromCamera(ImageSource.gallery);},
                child: UploadDialogInfo(
                  icon: Icons.photo_album_outlined,
                  userText: "Upload from Photos"
                ),
              ),
              h24Spacing
              ],
            ),
            ),
            ],
          ),
        );
  
        Widget buildHeader(BuildContext context, SheetState state) {
          return Container(
            child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 50,
                      height: 4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.black26,
                      )
                    ),
                  ),
                )
            ]
          ),
          );
        }
void _navigateToSettingScreen(context){
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final User?  user = _auth.currentUser;
  final String uid = user!.uid;
// userID: uid,
  Navigator.push(
    context,
    PageTransition(
    type: PageTransitionType.leftToRightJoined,
    childCurrent: widget,
    duration: Duration(milliseconds: 700),
    reverseDuration: Duration(milliseconds: 300),
    child: SettingScreen(userID: uid,)),
  );
}

// void _getFromGallery(ImageSource source) async {
//     PickedFile? pickedFile = await ImagePicker().getImage(6
//     source: ImageSource.gallery
//     maxHeight: 1080, 
//     maxWidth: 1080,
//     );
// }
// void _cropImage(filePath) async{
//       File? croppedImage = await ImageCropper().cropImage(
//         sourcePath: filePath,
//          maxWidth: 1080,
//         maxHeight: 1080,
//         // aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0)
//         );
//         if (croppedImage != null) {
//           setState(() {
//             _imageFile = croppedImage as PickedFile?;
//           });
//         }
// }

void getFromCamera(ImageSource source) async {
    final pickedFile = await _picker.getImage(
      source: source,
    );
    setState(() {
      _imageFile = pickedFile;
    });
    // _cropImage(pickedFile);
    // Navigator.pop(context);
}
}

// void _openGallery(BuildContext context) async{
//     final pickedFile = await ImagePicker().getImage(
//       source: ImageSource.gallery ,
//     );
//     setState(() {
//       imageFile = pickedFile!;
//     });

//     Navigator.pop(context);
//   }
//     void _openCamera(BuildContext context)  async{
//       final pickedFile = await ImagePicker().getImage(
//             source: ImageSource.camera ,
//             );
//             setState(() {
//             imageFile = pickedFile!;
//       });
//       Navigator.pop(context);
//   }




