import 'dart:io';
import 'package:balance/constants.dart';
import 'package:balance/fitsy_icons_set1_icons.dart';
import 'package:balance/screen/createClass/CreateClassStep1SelectType.dart';
import 'package:balance/screen/createClass/CreateClassStep7ClassLocation.dart';
import 'package:balance/screen/createClass/createClassStep5SelectCategory.dart';
import 'package:balance/screen/createClass/createClassStep8TitleAndPrice.dart';
import 'package:balance/feModels/ClassModel.dart';
import 'package:balance/sharedWidgets/loginFooterButton.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
  File? tempImage;

  //----------
  @override
  void initState() {
    super.initState();
    print(widget.classTemplate.classImageUrl);
  }

  //----------
  @override
  Future pickImage(ImageSource source) async {
    try {
      var image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) {
        image = XFile('assets/images/profilePictureDefault.png');
        return;
      }

      setState(() {
        if (image != null) {
          tempImage = File(image.path);
        }
      });
    } on PlatformException catch (e) {
      print('Failed to pick image $e');
    }
  }

  Future uploadImage() async {
    if (tempImage == null) return;

    try {
      //Storage Reference
      final firebaseStorage = FirebaseStorage.instance.ref();

      //Create a reference to image
      // print(tempImage!.path);
      final profilePictureRef = firebaseStorage.child(tempImage!.path);

      //Upload file. FILE MUST EXIST
      await profilePictureRef.putFile(tempImage!);

      final imageURL = await profilePictureRef.getDownloadURL();

      classTemplate.classImageUrl = imageURL;
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: snow,
      appBar: AppBar(
        toolbarHeight: 50,
        centerTitle: false,
        elevation: 0,
        backgroundColor: snow,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(left: 0),
          child: Row(
            children: [
              GestureDetector(
                child: Row(
                  children: [
                    Icon(
                      FitsyIconsSet1.arrowleft,
                      color: jetBlack60,
                      size: 15,
                    ),
                    const Text(
                      "Back",
                      style: logInPageNavigationButtons,
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.of(context).pop(CupertinoPageRoute(
                      fullscreenDialog: true,
                      builder: (context) => CreateClassCategory(
                            classTemplate: classTemplate,
                          )));
                },
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 8,
          left: 15.0,
          right: 15.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: pageTitle(),
              ),
            ]),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Center(
                  child: GestureDetector(
                child: Container(
                    height: MediaQuery.of(context).size.height * 0.60,
                    width: MediaQuery.of(context).size.width * 0.92,
                    decoration: BoxDecoration(
                        color: snow,
                        border: Border.all(
                          strokeAlign: BorderSide.strokeAlignOutside,
                          width: 1,
                          color: tempImage != null ? snow : jetBlack40,
                        ),
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        tempImage != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.60,
                                  width:
                                      MediaQuery.of(context).size.width * 0.92,
                                  child: FittedBox(
                                    fit: BoxFit.cover,
                                    child: Image.file(
                                      tempImage!,
                                    ),
                                  ),
                                ),
                              )
                            : const Column(
                                children: [
                                  Icon(
                                    FitsyIconsSet1.upload,
                                    size: 30,
                                    color: jetBlack60,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 10.0),
                                    child: Text(
                                      'Click here to upload',
                                      style: logInPageBodyText,
                                    ),
                                  )
                                ],
                              ),
                      ],
                    )),
                onTap: () {
                  pickImage(ImageSource.gallery);
                },
              )),
            ),
            if (tempImage != null)
              const Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Center(
                  child: Text(
                    'Click your image to change it before continuing',
                    style: logInPageBodyTextNote,
                  ),
                ),
              )
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 110,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 15.0,
                right: 15.0,
                bottom: 55.0,
              ),
              child: GestureDetector(
                child: FooterButton(
                    buttonColor: strawberry,
                    textColor: snow,
                    buttonText: 'Continue'),
                onTap: () {
                  switch (widget.classTemplate.classType) {
                    case ClassType.Solo:
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SelectClassLocation(
                              classTemplate: widget.classTemplate)));
                      break;
                    case ClassType.Group:
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SelectClassLocation(
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
  return Container(
      padding: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(color: snow),
      child: const Text(
        'Upload a picture for your class',
        style: logInPageTitleH3,
      ));
}
