import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../constants.dart';

class ClassItemCondensed1 extends StatelessWidget {
  ClassItemCondensed1({
    Key? key,
    required this.classImageUrl,
    required this.buttonBookOrRebookText,
    required this.classTitle,
    required this.classTrainer,
    required this.classTrainerImageUrl,
  }) : super(key: key);

  String classImageUrl;
  String buttonBookOrRebookText;
  String classTitle;
  String classTrainer;
  String classTrainerImageUrl;

//Edit Profile button
  Widget bookClassButton() {
    return Container(
      alignment: Alignment.center,
      height: 35,
      width: 75,
      decoration: BoxDecoration(
          color: jetBlack,
          // border: Border.all(color: shark60),
          borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
        child: Text(
          buttonBookOrRebookText,
          style: TextStyle(
              color: snow,
              fontFamily: 'SFDisplay',
              fontSize: 13.0,
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width - (26 * 2);
    return Column(
      children: [
        //Upcoming Class Card
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  //Class Image
                  Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                            image: NetworkImage(classImageUrl),
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),

                  //Class Details
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //Class Title
                        SizedBox(
                          width: 160,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 3.0),
                            child: Text(
                              classTitle,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: jetBlack,
                                  fontFamily: 'SFDisplay'),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),

                        //Class Trainer
                        Row(
                          children: [
                            Text(
                              'with ' + classTrainer,
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: jetBlack40,
                                  fontFamily: 'SFDisplay'),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 4.0),
                              child: CircleAvatar(
                                radius: 8,
                                foregroundImage:
                                    NetworkImage(classTrainerImageUrl),
                                backgroundColor: Colors.transparent,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: bookClassButton())
            ],
          ),
        ),
      ],
    );
  }
}
