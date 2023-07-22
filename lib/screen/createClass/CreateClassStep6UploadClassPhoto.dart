import 'dart:io';
import 'package:balance/constants.dart';
import 'package:balance/screen/createClass/CreateClassStep1SelectType.dart';
import 'package:balance/screen/createClass/createClassStep5SelectCategory.dart';
import 'package:balance/screen/createClass/createClassStep7TitleAndPrice.dart';
import 'package:balance/feModels/ClassModel.dart';
import 'package:balance/sharedWidgets/loginFooterButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sliver_tools/sliver_tools.dart';

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
      classTemplate.profileImageTempHolder = imageTemporary;
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
        toolbarHeight: 0,
        elevation: 0,
        backgroundColor: snow,
      ),
      body: CustomScrollView(physics: NeverScrollableScrollPhysics(), slivers: [
        SliverAppBar(
          toolbarHeight: 80,
          pinned: false,
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
                    Navigator.of(context).pop(CupertinoPageRoute(
                        fullscreenDialog: true,
                        builder: (context) =>
                            CreateClassCategory(classTemplate: classTemplate)));
                  },
                  child: Text("Back", style: logInPageNavigationButtons),
                ),
              ),
            ],
          ),
        ),
        MultiSliver(children: [
          pageTitle(),
          Center(
              child: Padding(
            padding: EdgeInsets.only(left: 26, right: 26, top: 20),
            child: Container(
              width: double.maxFinite,
              height: 420,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: bone,
                  image: image != null
                      ? DecorationImage(
                          image: FileImage(image!), fit: BoxFit.cover)
                      : DecorationImage(
                          image: AssetImage(
                              'assets/images/createClass/uploadClassImage.png'),
                          fit: BoxFit.contain)),
            ),
          )),
        ])
      ]),
      bottomNavigationBar: SizedBox(
        height: 175,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 15.0,
                bottom: 15.0,
              ),
              child: GestureDetector(
                child: FooterButton(
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
                child: FooterButton(
                    buttonColor: strawberry,
                    textColor: snow,
                    buttonText: 'Continue'),
                onTap: () {
                  print(widget.classTemplate.classType
                      .toString()
                      .split('.')
                      .last);
                  switch (widget.classTemplate.classType) {
                    case ClassType.Solo:
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CreateClassTitleAndPrice(
                              classTemplate: widget.classTemplate)));
                      break;
                    case ClassType.Group:
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CreateClassTitleAndPrice(
                              classTemplate: widget.classTemplate)));
                      break;
                    case ClassType.Virtual:
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CreateClassTitleAndPrice(
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
          padding: EdgeInsets.only(top: 10),
          decoration: BoxDecoration(color: snow),
          child: Text(
            'Upload a picture for your class',
            style: logInPageTitle,
            textAlign: TextAlign.center,
          )),
    ),
  );
}
