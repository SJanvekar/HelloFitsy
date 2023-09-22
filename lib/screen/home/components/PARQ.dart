// ignore_for_file: non_constant_identifier_names, prefer_const_constructors
import 'package:balance/constants.dart';
import 'package:balance/feModels/UserModel.dart';
import 'package:balance/hello_fitsy_icons.dart';
import 'package:balance/sharedWidgets/loginFooterButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_survey/flutter_survey.dart';

class ParQuestionnaire extends StatefulWidget {
  ParQuestionnaire({Key? key}) : super(key: key);

  @override
  State<ParQuestionnaire> createState() => _ParQuestionnaire();
}

class _ParQuestionnaire extends State<ParQuestionnaire> {
  // ignore: prefer_const_constructors_in_immutables

  List<User> userParQuestionnaireResult = [];
  void retrieveParQuestionnaireResult(List<User> newResult) {
    setState(() {
      userParQuestionnaireResult = newResult;
    });
  }

  final _formKey = GlobalKey<FormState>();

  List<QuestionResult> _questionResults = [];
  final List<Question> _initialData = [
    Question(
      isMandatory: true,
      question: 'What are your goals?',
    ),
    Question(
      isMandatory: true,
      question: 'Height (cm)',
    ),
    Question(
      isMandatory: true,
      question: 'Weight (Lbs)',
    ),
    Question(
        isMandatory: true,
        question:
            'What intensity do you like to be coached at?          (1 - Relaxed, 10 - Hardcore) -- Change this?',
        answerChoices: const {
          "1": null,
          "2": null,
          "3": null,
          "4": null,
          "5": null,
          "6": null,
          "7": null,
          "8": null,
          "9": null,
          "10": null,
        }),
    Question(
        singleChoice: false,
        question: "Do you have any of the following health issues?",
        answerChoices: {
          "Heart problems": null,
          "Circulatory problems": null,
          "High/Low Blood pressure": null,
          "Joint/Movement problems": null,
          "Dizziness/Imbalance during exercise": null,
          "Currently pregnant/Recently given birth": null,
          "Injuries": [
            Question(question: 'Please specify'),
          ],
        }),
    Question(
        singleChoice: false,
        question: "Please select any of the following that are applicable:",
        answerChoices: {
          "Back/Spinal problems": null,
          "Headaches/Migranes": null,
          "Undergone recent Surgery": null,
          "Taking prescribed medication": null,
          "Recently finished a course of medication": null,
          "Diabetes": null,
          "Asthma/Breathing problems": null
        }),
    Question(
        question: 'If you have selected any of the above, please specify:'),
    Question(
        isMandatory: true,
        singleChoice: false,
        question:
            'By selecting the checkbox below, I agree that all of the information provided above is accurate and true',
        answerChoices: {
          "I Agree": null,
        })
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        backgroundColor: snow,

        //Appbar (White top, this should be consitent on every page.)
        appBar: AppBar(
          toolbarHeight: 170,
          elevation: 0,
          backgroundColor: snow,
          // Title
          flexibleSpace: Padding(
            padding: EdgeInsets.only(left: 26, top: 80),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Row(
                    children: [
                      Icon(
                        HelloFitsy.arrowleft,
                        size: 13,
                        color: jetBlack80,
                      ),
                      GestureDetector(
                        child: Text(
                          'Home',
                          style: logInPageNavigationButtons,
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ),
                Image.asset(
                  'assets/images/Typeface.png',
                  height: 44,
                ),
                Text('Phyiscal Activity Readiness Questionnaire',
                    style: pageTitles),
              ],
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Form(
                  key: _formKey,
                  child: Survey(
                      onNext: (questionResults) {
                        _questionResults = questionResults;
                      },
                      initialData: _initialData),
                ),
              ),
            ),
            SizedBox(
              height: 100,
              child: SizedBox(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 26.0, right: 26.0, bottom: 50),
                  child: Container(
                    height: 20,
                    child: FooterButton(
                        buttonColor: strawberry,
                        textColor: snow,
                        buttonText: 'Submit'),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      onTap: () => {FocusScope.of(context).requestFocus(new FocusNode())},
    );
  }
}
