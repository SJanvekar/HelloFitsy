import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:balance/Constants.dart';
import 'package:balance/feModels/ClassModel.dart';
import 'package:balance/fitsy_icons_set1_icons.dart';
import 'package:balance/sharedWidgets/PageDivider.dart';
import 'package:balance/sharedWidgets/classes/ClassItemCondensed1.dart';
import 'package:balance/sharedWidgets/userProfileComponentLight.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_stack/image_stack.dart';
import 'package:jiffy/jiffy.dart';
import 'package:sliver_tools/sliver_tools.dart';

class UpcomingClassMoreInfo extends StatefulWidget {
  UpcomingClassMoreInfo({Key? key, required this.classItem}) : super(key: key);

  Class classItem;

  @override
  State<UpcomingClassMoreInfo> createState() => _UpcomingClassMoreInfoState();
}

class _UpcomingClassMoreInfoState extends State<UpcomingClassMoreInfo> {
  @override
  Widget build(BuildContext context) {
    // Dummy list of attendees (replace this with your actual list)

    List<String> images = [
      "https://discussions.apple.com/content/attachment/6692d3b3-c2bb-43df-8b66-a2aa2563039b",
      "https://pbs.twimg.com/media/FUF_4icX0AEpADE.jpg:large",
      "https://i.pinimg.com/736x/0a/77/bd/0a77bd2f3ec660921eccfb1c9910a688.jpg",
      "https://i.pinimg.com/564x/60/9c/57/609c57fe51bfd1c7b910b3997baecf61.jpg",
      "https://i.pinimg.com/originals/04/22/38/042238bb9d57fa8501bffac46bebad17.jpg",
      "https://global.discourse-cdn.com/infiniteflight/original/4X/9/b/e/9bef0cfeec11af975f1c1928ead8ccf7f94c8039.jpeg",
      "https://i.pinimg.com/originals/9e/4b/79/9e4b79df1915de606e4b20d153fdae4d.jpg"
    ];

    return Scaffold(
        backgroundColor: snow,
        appBar: AppBar(
          toolbarHeight: 40,
          centerTitle: false,
          elevation: 0,
          backgroundColor: snow,
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                child: const Row(
                  children: [
                    //Icon: arrowLeft from the Fitsy icon ttf library
                    Icon(
                      FitsyIconsSet1.arrowleft,
                      color: jetBlack80,
                      size: 14,
                    ),
                    Text("Back", style: logInPageNavigationButtons),
                  ],
                ),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
        body: CustomScrollView(slivers: [
          //AppBar Sliver
          SliverAppBar(
            floating: true,
            pinned: false,
            toolbarHeight: 40,
            elevation: 0,
            backgroundColor: snow,
            automaticallyImplyLeading: false,
            stretch: true,

            //Title
            flexibleSpace: Padding(
              padding: EdgeInsets.only(
                left: 15,
                top: 0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Class details', style: pageTitles),
                ],
              ),
            ),
          ),

          MultiSliver(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Text(
                          Jiffy.parseFromDateTime(DateTime.now())
                              .format(pattern: "MMMM do"),
                          style: classInfoDate),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Text(
                          Jiffy.parseFromDateTime(DateTime.now())
                                  .format(pattern: "h:mm a") +
                              ' - ' +
                              Jiffy.parseFromDateTime(DateTime.now())
                                  .format(pattern: "h:mm a"),
                          style: notificationDate),
                    ),
                  ],
                ),
              ),
              PageDivider(leftPadding: 15, rightPadding: 15),

              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 5.0, bottom: 15.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20.0),
                                    child: AutoSizeText(
                                        widget.classItem.className,
                                        minFontSize: 22,
                                        style: sectionTitlesMedium),
                                  )
                                ]),
                          ),
                        ],
                      )
                    ]),
              ),

              //Class What you'll need
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "What you'll need for your class",
                      style: sectionTitlesH2,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5, left: 15.0, right: 15.0),
                child: classWhatYouWillNeed(),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 15.0,
                ),
                child: PageDivider(leftPadding: 15, rightPadding: 15),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15.0, bottom: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "Who's going",
                      style: sectionTitlesH2,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: ImageStack(
                  imageList: images,
                  imageRadius: 50, // Radius of each images
                  imageCount: 10, // Maximum number of images to be shown
                  imageBorderWidth: 2.5, // Border width around the images
                  totalCount: images.length,
                  imageBorderColor: snow,
                  backgroundColor: shark40,
                  extraCountTextStyle: buttonText1Jetblack80,
                ),
              )
            ],
          ),
        ]));
  }

  // Text widget overflow checkers - Description
  bool showFullTextWhatYouWillNeed = false;

// Class What you will need
  Widget classWhatYouWillNeed() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            assert(constraints.hasBoundedWidth);
            final double maxWidth = constraints.maxWidth;
            final textSpan = TextSpan(
              style: profileBodyTextFont,
              text: widget.classItem.classUserRequirements,
            );

            TextDirection? direction = TextDirection.ltr;

            final textPainter = TextPainter(
              text: textSpan,
              textDirection: direction,
            );
            textPainter.layout(
              maxWidth: maxWidth,
            );

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    showFullTextWhatYouWillNeed
                        ? widget.classItem.classUserRequirements
                        : textSpan.toPlainText(),
                    maxLines:
                        showFullTextWhatYouWillNeed ? 30 : 7, // Add this line
                    overflow: TextOverflow.ellipsis,
                    style: profileBodyTextFont,
                  ),
                ),
                GestureDetector(
                  child: Text(
                      showFullTextWhatYouWillNeed ? 'See Less' : 'See More',
                      style: seeMoreText),
                  onTap: () {
                    setState(() {
                      HapticFeedback.selectionClick();
                      showFullTextWhatYouWillNeed =
                          !showFullTextWhatYouWillNeed;
                    });
                  },
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

Color _randomColor() {
  Random random = Random();
  return Color.fromRGBO(
    random.nextInt(256),
    random.nextInt(256),
    random.nextInt(256),
    1.0,
  );
}

String _getInitials(String name) {
  List<String> names = name.split(' ');
  String initials = '';
  int numWords = min(2, names.length); // Get at most first two words
  for (int i = 0; i < numWords; i++) {
    initials += names[i][0].toUpperCase();
  }
  return initials;
}
