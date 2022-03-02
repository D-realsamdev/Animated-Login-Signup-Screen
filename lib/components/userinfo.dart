// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, camel_case_types, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, unused_element, non_constant_identifier_names, avoid_types_as_parameter_names, unused_local_variable, deprecated_member_use, duplicate_ignore, import_of_legacy_library_into_null_safe, unused_import
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:image_picker/image_picker.dart';
import 'package:listing_app/constant.dart';
import 'package:sliding_sheet/sliding_sheet.dart';


class UserInfo extends StatelessWidget {
  const UserInfo({required this.icon, required this.userText});

  final IconData icon;
  final String userText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.black,
            size: 30,
          ),
          SizedBox(
            width: 10.0,
          ),
          Text(
            userText,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
          )
        ],
      ),
    );
  }
}



class UploadDialogInfo extends StatelessWidget {
  const UploadDialogInfo({required this.icon, required this.userText});

  final IconData icon;
  final String userText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 9),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.grey,
            size: 25,
          ),
          SizedBox(
            width: 10.0,
          ),
          Text(
            userText,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 15,
            ),
          )
        ],
      ),
    );
  }
}



class CustomTextField extends StatelessWidget {
  const CustomTextField({
    required this.onChanged,
    this.focusNode,
    this.hintText,
    this.labelText,
    this.obscureText,
    this.errorText,
    this.maxLine,
    this.message,
    this.keyboardType,
    this.textInputAction,
    this.borderOutlined = false,
    this.formKey,
    this.controller,
  });

  final String? hintText;
  final String? labelText;
  final bool? obscureText;
  final String? errorText;
  final int? maxLine;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final void Function(String) onChanged;
  final bool borderOutlined;
  final formKey;
  final String? message;
  final controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        controller: controller,
        validator: (value) {
          if (value!.isEmpty) {
            return message;
          } else {
            return null;
          }
        },
        key: formKey,
        // maxLines: maxLine,
        autocorrect: true,
        keyboardType: keyboardType ?? TextInputType.visiblePassword,
        onChanged: onChanged,
        textInputAction: textInputAction,
        focusNode: focusNode,
        obscureText: obscureText ?? false,
        decoration: InputDecoration(
          contentPadding:
              EdgeInsets.symmetric(vertical: 20.0),
          hintText: hintText,
          hintStyle: TextStyle(fontSize: 18),
          labelText: labelText,
          errorText: errorText,
          border: (borderOutlined)
              ? OutlineInputBorder(
                  borderSide: BorderSide(width: 2.0),
                  borderRadius: BorderRadius.circular(5.0),
                )
              : null,
          focusedBorder: (borderOutlined)
              ? OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 2.0,
                  ),
                )
              : UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 2.0,
                  ),
                ),
        ),
      ),
    );
  }

  static Widget label(BuildContext context, String text) {
    return Align(
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
        child: Text(
          text,
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      // alignment: Alignment.centerLeft,
    );
  }
}






void _tripEditModalBottomSheet(context) {
  showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
      builder: (BuildContext) {
        return Container(
          height: MediaQuery.of(context).size.height * .40,
          padding: EdgeInsets.symmetric(horizontal: 5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 0, 3),
                child: Text(
                  'Account Manager',
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ],
          ),
        );
      });
}





class AccountTile extends StatelessWidget {

  @override
  Widget build(BuildContext context) => SimpleSettingsTile(
    title: "Change password",
  );
}