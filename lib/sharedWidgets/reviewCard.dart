import 'package:balance/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 220,
        width: 323,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(width: 1.5, color: bone)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Reviewer Username
              Text('Salman Janvekar',
                  style: TextStyle(
                      fontFamily: 'SFDisplay',
                      color: jetBlack,
                      fontSize: 18,
                      fontWeight: FontWeight.w600)),

              //Review Date
              Text('January 9, 2022',
                  style: TextStyle(
                      fontFamily: 'SFDisplay',
                      color: jetBlack40,
                      fontSize: 17,
                      fontWeight: FontWeight.w400)),
              //Review Star rating
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: RatingBar.builder(
                  initialRating: 3,
                  unratedColor: shark40,
                  itemSize: 22,
                  glow: false,
                  ignoreGestures: true,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: sunflower,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
              ),

              //Review Body
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                    'This class is amazing! There could be a little more in terms of backhand technique focusm but other than that is was amazing to meet Federer and the team.',
                    style: TextStyle(
                        fontFamily: 'SFDisplay',
                        color: jetBlack,
                        fontSize: 16,
                        fontWeight: FontWeight.w600)),
              ),
            ],
          ),
        ));
  }
}
