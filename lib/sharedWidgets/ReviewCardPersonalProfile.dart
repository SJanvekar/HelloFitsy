import 'package:balance/constants.dart';
import 'package:balance/sharedWidgets/userProfileComponentLight.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var reviewDate = DateTime.now();
    var formattedReviewDate = DateFormat.yMMMMd().format(reviewDate);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Review Date Posted  //HARD CODED - MUST CHANGE
        Padding(
          padding: const EdgeInsets.only(
            bottom: 10.0,
          ),
          child: Text(
            formattedReviewDate,
            style: profileBodyTextFont,
          ),
        ),

        //Review Rating
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            SvgPicture.asset(
              'assets/icons/generalIcons/star.svg',
              color: sunflower,
              height: 18,
              width: 18,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 5.0,
              ),

              //HARD CODED - MUST CHANGE
              child: Text(
                '4.5',
                style: TextStyle(
                    color: jetBlack,
                    fontFamily: 'SFRounded',
                    fontSize: 16.5,
                    fontWeight: FontWeight.w800),
              ),
            ),
          ]),
        ),
        //Associated Class Title //HARD CODED - MUST CHANGE
        Text(
          'Youth Tennis Fundraiser Program held by the Sick Kids Cancer Society',
          style: sectionTitlesH2,
        ),
        //Review Body //HARD CODED - MUST CHANGE
        Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Text(
            'This class is amazing! There could be a little more in terms of backhand technique focus, but other than that is was amazing to meet Federer and the RF team.',
            style: profileBodyTextFont,
          ),
        ),
      ],
    );
  }
}
