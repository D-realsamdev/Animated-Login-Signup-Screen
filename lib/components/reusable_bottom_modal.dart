// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

Future  showSheet(context) => showSlidingBottomSheet(
   context,
  builder: (context) => SlidingSheetDialog(
    cornerRadius: 16,
    snapSpec: const SnapSpec(
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Change Password",
                  style: TextStyle(
                   fontSize: 20 
                  ),
                  ),
                  
              ),
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