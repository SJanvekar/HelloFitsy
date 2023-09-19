import 'package:flutter/material.dart';
import './Flutter_Survery_Constants.dart';
import '../models/question.dart';
import 'answer_choice_widget.dart';
import 'survey_form_field.dart';

class QuestionCard extends StatelessWidget {
  ///The parameter that contains the data pertaining to a question.
  final Question question;

  ///A callback function that must be called with answers to rebuild the survey elements.
  final void Function(List<String>) update;

  ///An optional method to call with the final value when the form is saved via FormState.save.
  final FormFieldSetter<List<String>>? onSaved;

  ///An optional method that validates an input. Returns an error string to display if the input is invalid, or null otherwise.
  final FormFieldValidator<List<String>>? validator;

  ///Used to configure the auto validation of FormField and Form widgets.
  final AutovalidateMode? autovalidateMode;

  ///Used to configure the default errorText for the validator.
  final String defaultErrorText;
  const QuestionCard(
      {Key? key,
      required this.question,
      required this.update,
      this.onSaved,
      this.validator,
      this.autovalidateMode,
      required this.defaultErrorText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SurveyFormField(
        defaultErrorText: defaultErrorText,
        question: question,
        onSaved: onSaved,
        validator: validator,
        autovalidateMode: autovalidateMode,
        builder: (FormFieldState<List<String>> state) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            child: Card(
              elevation: 0,
              color: snow,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                        top: 0, right: 20, left: 20, bottom: 6),
                    child: RichText(
                      text: TextSpan(
                          text: question.question,
                          style: questionTitles,
                          children: question.isMandatory
                              ? [
                                  const TextSpan(
                                      text: "*",
                                      style: TextStyle(color: strawberry))
                                ]
                              : null),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(
                          left: 4, right: 20, top: 0, bottom: 0),
                      child: AnswerChoiceWidget(
                          question: question,
                          onChange: (value) {
                            state.didChange(value);

                            update(value);
                          })),
                  if (state.hasError)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      child: Text(
                        state.errorText!,
                        style: const TextStyle(color: strawberry),
                      ),
                    ),
                  const SizedBox(
                    height: 12,
                  )
                ],
              ),
            ),
          );
        });
  }
}
