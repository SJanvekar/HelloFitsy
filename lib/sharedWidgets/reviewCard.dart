import 'package:balance/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var reviewDate = DateTime.now();
    var formattedReviewDate = DateFormat.yMMMMd().format(reviewDate);
    return Container(
        decoration: BoxDecoration(
          color: bone60,
          borderRadius: BorderRadius.circular(20),
          // border: Border.all(width: 1.5, color: bone)
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Review Rating
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/generalIcons/star.svg',
                        color: sunflower,
                        height: 17.5,
                        width: 17.5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 5.0,
                        ),
                        child: Text(
                          '4.5',
                          style: TextStyle(
                              color: jetBlack,
                              fontFamily: 'SFRounded',
                              fontSize: 20.0,
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                    ]),
              ),

              //Reviewer Username
              Text('Salman Janvekar',
                  style: TextStyle(
                      fontFamily: 'SFDisplay',
                      color: jetBlack,
                      fontSize: 15,
                      fontWeight: FontWeight.w600)),

              //Review Date
              Padding(
                padding: const EdgeInsets.only(top: 2.0),
                child: Text('$formattedReviewDate',
                    style: TextStyle(
                        fontFamily: 'SFDisplay',
                        color: jetBlack40,
                        fontSize: 15,
                        fontWeight: FontWeight.w400)),
              ),

              //Review Body
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                    'This class is amazing! There could be a little more in terms of backhand technique focus, but other than that is was amazing to meet Federer and the RF team.',
                    style: TextStyle(
                        fontFamily: 'SFDisplay',
                        color: jetBlack,
                        fontSize: 14,
                        fontWeight: FontWeight.w500)),
              ),
            ],
          ),
        ));
  }
}
