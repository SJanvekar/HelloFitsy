import 'dart:io';
import 'package:balance/sharedWidgets/categories/addRemoveButton.dart';
import 'package:balance/feModels/classModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../constants.dart';

class CreateClassTimeList extends StatefulWidget {
  const CreateClassTimeList({Key? key, required this.classTimes})
      : super(key: key);

  final List<Schedule> classTimes;

  @override
  State<CreateClassTimeList> createState() => _CreateClassTimeListState();
}

class _CreateClassTimeListState extends State<CreateClassTimeList> {
  var _inputController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: widget.classTimes.length,
            itemBuilder: (context, index) {
              if (widget.classTimes.isEmpty) {
                return Container();
              } else {
                final times = widget.classTimes[index];
                return Padding(
                  padding: const EdgeInsets.only(
                      right: 15, left: 15, top: 5, bottom: 5),
                  child: Container(
                    decoration: BoxDecoration(
                        color: bone40,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 10, top: 10),
                          child: Row(
                            children: [
                              SvgPicture.asset("assets/icons/removeIcon20.svg"),
                              Expanded(
                                child: Text(
                                  DateFormat.yMMMd().format(times.startDate),
                                  style: const TextStyle(
                                    fontFamily: 'SFDisplay',
                                    color: jetBlack,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              )
                            ],
                          ),
                        ),
                        const Divider(
                          color: bone,
                          thickness: 2,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 24, right: 24, top: 10, bottom: 10),
                          child: Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(right: 10),
                                child: Text(
                                  "Start",
                                  style: TextStyle(
                                    fontFamily: 'SFDisplay',
                                    color: jetBlack,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: bone,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                padding: EdgeInsets.only(
                                    left: 18, right: 18, top: 6, bottom: 6),
                                child: Text(
                                  DateFormat.jm().format(times.startDate),
                                  style: TextStyle(
                                    fontFamily: 'SFDisplay',
                                    color: jetBlack,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(right: 10, left: 15),
                                child: Text(
                                  "End",
                                  style: TextStyle(
                                    fontFamily: 'SFDisplay',
                                    color: jetBlack,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: bone,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                padding: EdgeInsets.only(
                                    left: 18, right: 18, top: 6, bottom: 6),
                                child: Text(
                                  DateFormat.jm().format(times.endDate),
                                  style: TextStyle(
                                    fontFamily: 'SFDisplay',
                                    color: jetBlack,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }
            })
      ],
    );
  }

  void refresh() {
    setState(() {});
  }
}
