import 'dart:io';
import 'package:balance/sharedWidgets/categories/addRemoveButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants.dart';

class CreateClassTimeList extends StatefulWidget {
  const CreateClassTimeList({Key? key}) : super(key: key);

  @override
  State<CreateClassTimeList> createState() => _CreateClassTimeListState();
}

List<DateTime> sampleTimes = [DateTime.now(), DateTime.utc(2001, 9, 11, 8, 14)];

class _CreateClassTimeListState extends State<CreateClassTimeList> {
  var _inputController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1, crossAxisSpacing: 0, mainAxisSpacing: 20),
            itemCount: sampleTimes.length,
            itemBuilder: (context, index) {
              final times = sampleTimes[index];
              String timesText =
                  "${times.month.toString()} ${times.day.toString()}, ${times.year.toString()}";
              return Container(
                padding: const EdgeInsets.only(
                    right: 26, left: 26, top: 10, bottom: 10),
                decoration: BoxDecoration(
                    color: bone,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Column(
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset("assets/icons/removeIcon20.svg"),
                        Text(
                          timesText,
                          style: const TextStyle(
                            fontFamily: 'SFDisplay',
                            color: jetBlack,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                    const Divider(
                      color: bone,
                      thickness: 2,
                    ),
                    Row(
                      children: [
                        const Text(
                          "Start",
                          style: TextStyle(
                            fontFamily: 'SFDisplay',
                            color: jetBlack,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: bone,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Text(
                            "5:00 PM",
                            style: TextStyle(
                              fontFamily: 'SFDisplay',
                              color: jetBlack,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const Text(
                          "End",
                          style: TextStyle(
                            fontFamily: 'SFDisplay',
                            color: jetBlack,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: bone,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Text(
                            "5:00 AM",
                            style: TextStyle(
                              fontFamily: 'SFDisplay',
                              color: jetBlack,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              );
            })
      ],
    );
  }

  void refresh() {
    setState(() {});
  }
}
