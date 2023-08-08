import 'dart:ui';
import 'package:balance/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDialogBox extends StatefulWidget {
  final String trainerName;
  final String trainerImg;

  const CustomDialogBox(
      {Key? key, required this.trainerName, required this.trainerImg})
      : super(key: key);

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
          ]),
      child: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 40,
                backgroundImage: NetworkImage(widget.trainerImg),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5.0, right: 5.0),
              child: Text(
                'Are you sure you want to unfollow ' + widget.trainerName + '?',
                style: TextStyle(
                    color: jetBlack80,
                    fontFamily: 'SFDisplay',
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Column(
              children: [
                GestureDetector(
                    child: Container(
                      alignment: Alignment.center,
                      height: 40,
                      width: 105,
                      decoration: BoxDecoration(
                          color: strawberry,
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        'Unfollow',
                        style: TextStyle(
                            color: snow,
                            fontFamily: 'SFDisplay',
                            fontSize: 13,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    onTap: () => {Navigator.of(context).pop()}),
                SizedBox(height: 5),
                GestureDetector(
                    child: Container(
                      alignment: Alignment.center,
                      height: 40,
                      width: 105,
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                            color: jetBlack80,
                            fontFamily: 'SFDisplay',
                            fontSize: 13,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    onTap: () => {Navigator.of(context).pop()}),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
