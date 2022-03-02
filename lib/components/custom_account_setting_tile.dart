// ignore_for_file: prefer_const_constructors, import_of_legacy_library_into_null_safe, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:listing_app/constant.dart';

class AccountTile extends StatelessWidget {

  @override
  Widget build(BuildContext context) => SimpleSettingsTile(
    title: "Change password",
  );
}


 Divider lightDivider() {
    return Divider(
      thickness: 2.0,
      indent: 0,
      endIndent: 0,
      color: Colors.blueGrey.withOpacity(0.2),
    );
  }

  Divider thickDivider() {
    return Divider(
      thickness: 4.0,
      indent: 0,
      endIndent: 0,
      color: Colors.blueGrey.withOpacity(0.1),
    );
  }

  GestureDetector buildAccountTile(String title,) {
    return GestureDetector(
        onTap: (){},
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(  
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                fontSize: 20,
                color: Colors.black
                )
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: pHeadColor,
              )
            ]
          ),
        ),
    );
  }
