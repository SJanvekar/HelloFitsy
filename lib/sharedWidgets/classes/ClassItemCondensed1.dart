import 'dart:async';
import 'package:balance/feModels/ClassModel.dart';
import 'package:balance/feModels/UserModel.dart';
import 'package:balance/screen/home/components/PurchaseClassSelectDates.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import '../../constants.dart';

class ClassItemCondensed1 extends StatelessWidget {
  ClassItemCondensed1({
    Key? key,
    required this.classImageUrl,
    required this.buttonBookOrRebookText,
    required this.classTitle,
    required this.classItem,
    required this.userInstance,
  }) : super(key: key);

  String classImageUrl;
  String buttonBookOrRebookText;
  String classTitle;
  Class classItem;
  User userInstance;
  late User classTrainerInstance;

  @override
  Widget build(BuildContext context) {
//Edit Profile button
    Widget bookClassButton() {
      return GestureDetector(
        child: Container(
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
        ),
        onTap: () {
          HapticFeedback.lightImpact();
          Timer(Duration(milliseconds: 150), () {
            showCupertinoModalPopup(
                semanticsDismissible: true,
                barrierDismissible: true,
                barrierColor: jetBlack60,
                context: context,
                builder: (BuildContext builder) {
                  return PurchaseClassSelectDates(
                    classItem: classItem,
                    userInstance: userInstance,
                    trainerStripeAccountID:
                        classTrainerInstance.stripeAccountID ?? '',
                    classTrainerInstance: classTrainerInstance,
                  );
                });
          });
        },
      );
    }

    var width = MediaQuery.of(context).size.width - (15 * 2);
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
