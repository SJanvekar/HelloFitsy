import 'package:flutter/material.dart';

//http://localhost:8888
//https://www.fitsy.ca
const String urlDomain = 'http://localhost:8888';

const String publishableStripeKey =
    'pk_test_51N1KMLHPTcKdqvMqmxEGhpnBnrFS7KKdymTmwZlByroml00eU2g0ocRutSqH2K4WFTAx2BAmxLPFpvwhCzsb7nC900JCQMgDCH';

//----MONGOOSE ERROR CODES-------------//
const int duplicateKeycode = 11000;

//-----------NEW--------------------//

//Snow
const snow = Color(0xffFDFCFC);

//shadows
const blueMusk = Color(0xff7090B0);

//Strawberry
const strawberry = Color(0xffE6373A);
const strawberry80 = Color(0xccE6373A);
const strawberry60 = Color(0x99E6373A);
const strawberry40 = Color(0x66E6373A);
const strawberry20 = Color(0x33E6373A);

//Strawberry
const emerald = Color(0xff0BD4A4);
const emerald80 = Color(0xcc0BD4A4);
const emerald60 = Color(0x990BD4A4);
const emerald40 = Color(0x660BD4A4);
const emerald20 = Color(0x330BD4A4);

//JetBlack
const jetBlack = Color(0xff23292F);
const jetBlack80 = Color(0xcc23292F);
const jetBlack60 = Color(0x9923292F);
const jetBlack40 = Color(0x6623292F);
const jetBlack20 = Color(0x3323292F);

//Tarmac
const tarmac = Color(0xff515860);

//Bone
const bone = Color(0xffEFF2F3);
const bone80 = Color(0xccEFF2F3);
const bone60 = Color(0x99EFF2F3);
const bone40 = Color(0x66EFF2F3);
const bone20 = Color(0x33EFF2F3);

//Shark
const shark = Color(0xffD0D4D9);
const shark80 = Color(0xccD0D4D9);
const shark60 = Color(0x99D0D4D9);
const shark40 = Color(0x66D0D4D9);
const shark20 = Color(0x33D0D4D9);

//Ocean
const ocean = Color(0xff4A83E2);
const ocean80 = Color(0xcc4A83E2);
const ocean60 = Color(0x994A83E2);
const ocean40 = Color(0x664A83E2);
const ocean20 = Color(0x334A83E2);

//Sunflower
const sunflower = Color(0xffFFC851);
const sunflower80 = Color(0xccFFC851);
const sunflower60 = Color(0x99FFC851);
const sunflower40 = Color(0x66FFC851);
const sunflower20 = Color(0x33FFC851);

//Old Palette

//Padding
const defaultPadding = 10.0;

//Fonts

//LOG IN SPECIFIC FONTS
const logInPageTitle = TextStyle(
  fontFamily: 'SFDisplay',
  color: jetBlack,
  fontSize: 26,
  fontWeight: FontWeight.w600,
);

const logInPageNavigationButtons = TextStyle(
  fontFamily: 'SFDisplay',
  color: jetBlack80,
  fontSize: 17,
  fontWeight: FontWeight.w500,
);

const logInPageBodyText = TextStyle(
    fontFamily: 'SFDisplay',
    color: jetBlack40,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    decoration: TextDecoration.none);

const logInPageBodyStrawberry = TextStyle(
    fontFamily: 'SFDisplay',
    color: strawberry,
    fontSize: 15,
    fontWeight: FontWeight.w400,
    decoration: TextDecoration.none);

//GENERAL FONTS
const disclaimerTitle = TextStyle(
    color: jetBlack,
    fontFamily: 'SFDisplay',
    fontSize: 17,
    fontWeight: FontWeight.w600,
    decoration: TextDecoration.none);

const pageTitles = TextStyle(
  fontFamily: 'SFDisplay',
  color: jetBlack,
  fontSize: 24,
  fontWeight: FontWeight.w600,
  decoration: TextDecoration.none,
);

const homeFeedTitle = TextStyle(
    fontFamily: 'SFDisplay',
    color: jetBlack,
    fontSize: 15,
    fontWeight: FontWeight.w400,
    decoration: TextDecoration.none);

const sectionTitles = TextStyle(
  fontFamily: 'SFDisplay',
  color: jetBlack,
  fontSize: 19,
  fontWeight: FontWeight.w600,
  decoration: TextDecoration.none,
);

const sectionTitlesH2 = TextStyle(
  fontFamily: 'SFDisplay',
  color: jetBlack,
  fontSize: 16,
  fontWeight: FontWeight.w600,
  decoration: TextDecoration.none,
);

const sectionTitlesClassCreation = TextStyle(
  fontFamily: 'SFDisplay',
  color: jetBlack,
  fontSize: 19,
  fontWeight: FontWeight.w600,
  decoration: TextDecoration.none,
);

const dateSelectionTitle = TextStyle(
  fontFamily: 'SFDisplay',
  color: jetBlack,
  fontSize: 22.0,
  fontWeight: FontWeight.w600,
  decoration: TextDecoration.none,
);

const classStartTime = TextStyle(
    color: jetBlack,
    fontFamily: 'SFRounded',
    fontSize: 13,
    fontWeight: FontWeight.w600);

const classEndTime = TextStyle(
    color: jetBlack40,
    fontFamily: 'SFRounded',
    fontSize: 13,
    fontWeight: FontWeight.w600);

const classStartTimeSelected = TextStyle(
    color: snow,
    fontFamily: 'SFRounded',
    fontSize: 13,
    fontWeight: FontWeight.w600);

const classEndTimeSelected = TextStyle(
    color: snow,
    fontFamily: 'SFRounded',
    fontSize: 13,
    fontWeight: FontWeight.w600);

const settingsDefaultHeaderText = TextStyle(
    fontFamily: 'SFDisplay',
    color: jetBlack,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    decoration: TextDecoration.none);

const settingsDefaultSelectionText = TextStyle(
    fontFamily: 'SFDisplay',
    color: jetBlack60,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    decoration: TextDecoration.none);

const popUpMenuText = TextStyle(
    fontFamily: 'SFDisplay',
    color: jetBlack60,
    fontSize: 15,
    fontWeight: FontWeight.w500,
    decoration: TextDecoration.none);

const emptyListDisclaimerText = TextStyle(
    color: jetBlack40,
    fontFamily: 'SFDisplay',
    fontSize: 15,
    fontWeight: FontWeight.w400);

const doneTextButton = TextStyle(
  fontFamily: 'SFDisplay',
  color: ocean,
  fontSize: 17,
  fontWeight: FontWeight.w600,
);

const subheader1Font = TextStyle(
    color: jetBlack60,
    fontFamily: 'SFDisplay',
    fontSize: 16,
    fontWeight: FontWeight.w500);

const roundedNumberStyle1LightShadow = TextStyle(
  fontFamily: 'SFRounded',
  color: snow,
  fontSize: 14,
  fontWeight: FontWeight.w600,
  decoration: TextDecoration.none,
  shadows: <Shadow>[
    Shadow(
      offset: Offset(0, 0),
      blurRadius: 8.0,
      color: jetBlack80,
    ),
  ],
);

const roundedNumberStyle1LightShadowUnderlined = TextStyle(
  fontFamily: 'SFRounded',
  color: snow,
  fontSize: 13,
  fontWeight: FontWeight.w600,
  decoration: TextDecoration.underline,
  decorationStyle: TextDecorationStyle.solid,
  shadows: <Shadow>[
    Shadow(
      offset: Offset(0, 0),
      blurRadius: 8.0,
      color: jetBlack80,
    ),
  ],
);

const roundedBodyTextStyle1 = TextStyle(
  fontFamily: 'SFRounded',
  color: snow,
  fontSize: 12,
  fontWeight: FontWeight.w600,
  decoration: TextDecoration.none,
);

const buttonText1Jetblack80 = TextStyle(
  fontFamily: 'SFRounded',
  color: jetBlack80,
  fontSize: 14,
  fontWeight: FontWeight.w600,
  decoration: TextDecoration.none,
);

const buttonText3Jetblack40 = TextStyle(
  fontFamily: 'SFRounded',
  color: jetBlack40,
  fontSize: 14,
  fontWeight: FontWeight.w100,
  decoration: TextDecoration.none,
);

const buttonText2snow = TextStyle(
  fontFamily: 'SFRounded',
  color: snow,
  fontSize: 14,
  fontWeight: FontWeight.w600,
  decoration: TextDecoration.none,
);
const bodyTextFontBold80 = TextStyle(
    color: jetBlack80,
    fontFamily: 'SFDisplay',
    fontSize: 14.5,
    fontWeight: FontWeight.w600);

//PROFILE SPECIFIC FONTS
const profileBodyTextFont = TextStyle(
    color: jetBlack80,
    fontFamily: 'SFDisplay',
    fontSize: 14.5,
    fontWeight: FontWeight.w400);

//TEXT BUTTON STYLES

//NO SPLASH
var textButtonStyleNoSplash = ButtonStyle(
  overlayColor: MaterialStateProperty.all(Colors.transparent),
);
