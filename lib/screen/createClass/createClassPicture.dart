import 'dart:io';
import 'package:balance/constants.dart';
import 'package:balance/screen/createClass/createClassCategory.dart';
import 'package:balance/screen/createClass/createClassDetails.dart';
import 'package:balance/screen/createClass/createClassDocument.dart';
import 'package:balance/screen/login/components/categorySelection.dart';
import 'package:balance/screen/login/components/personalInfo.dart';
import 'package:balance/screen/login/components/profilePictureUpload.dart';
import 'package:balance/feModels/classModel.dart';
import 'package:balance/sharedWidgets/loginFooterButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

class CreateClassPicture extends StatefulWidget {
  CreateClassPicture({Key? key, required this.classTemplate}) : super(key: key);

  final Class classTemplate;

  @override
  State<CreateClassPicture> createState() => _CreateClassPicture();
}

class _CreateClassPicture extends State<CreateClassPicture> {
  File? image;

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) {
        final image = AssetImage('assets/images/profilePictureDefault.png');
        return;
      }

      final imageTemporary = File(image.path);
      setState(() => this.image = imageTemporary);
    } on PlatformException catch (e) {
      print('Failed to pick image $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: snow,
      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: false,
        elevation: 0,
        backgroundColor: snow,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 0,
              ),
              child: TextButton(
                onPressed: () {
                  print("Back");
                  // Navigator.of(context).pop(CupertinoPageRoute(
                  //     fullscreenDialog: true,
                  //     builder: (context) => ProfilePictureUpload()));
                },
                child: Text("Back", style: logInPageNavigationButtons),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            pageTitle(),

            Center(
                child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 26, right: 26, top: 50),
                  child: Column(
                    children: [
                      image != null
                          ? Image.file(
                              image!,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              'assets/images/createClass/uploadClassImage.png',
                            ),
                    ],
                  ),
                )
              ],
            )),

            //Slider Stuff
            Padding(
              padding: const EdgeInsets.only(top: 50, bottom: 15),
              child: GestureDetector(
                child: LoginFooterButton(
                    buttonColor: ocean,
                    textColor: snow,
                    buttonText: 'Upload Picture'),
                onTap: () => {
                  pickImage(ImageSource.gallery),
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 45.0),
              child: GestureDetector(
                child: LoginFooterButton(
                    buttonColor: strawberry,
                    textColor: snow,
                    buttonText: 'Continue'),
                onTap: () {
                  print(widget.classTemplate.classType
                      .toString()
                      .split('.')
                      .last);
                  switch (widget.classTemplate.classType) {
                    case ClassType.solo:
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CreateClassCategory(
                              classTemplate: widget.classTemplate)));
                      break;
                    case ClassType.group:
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CreateClassCategory(
                              classTemplate: widget.classTemplate)));
                      break;
                    case ClassType.virtual:
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CreateClassDocument(
                              classTemplate: widget.classTemplate)));
                      break;
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//Page title
Widget pageTitle() {
  return Center(
    child: Padding(
      padding: const EdgeInsets.only(
        left: 46.5,
        right: 46.5,
      ),
      child: Container(
          padding: EdgeInsets.only(top: 25),
          decoration: BoxDecoration(color: snow),
          child: Text(
            'Upload a picture for your class',
            style: logInPageTitle,
            textAlign: TextAlign.center,
          )),
    ),
  );
}
