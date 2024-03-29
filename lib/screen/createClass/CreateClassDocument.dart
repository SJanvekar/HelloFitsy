import 'dart:io';
import 'package:balance/constants.dart';
import 'package:balance/screen/createClass/createClassStep5SelectCategory.dart';
import 'package:balance/feModels/ClassModel.dart';
import 'package:balance/sharedWidgets/FooterButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class CreateClassDocument extends StatefulWidget {
  CreateClassDocument({Key? key, required this.classTemplate})
      : super(key: key);

  final Class classTemplate;

  @override
  State<CreateClassDocument> createState() => _CreateClassDocument();
}

class _CreateClassDocument extends State<CreateClassDocument> {
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
                  Navigator.of(context).pop();
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
                child: FooterButton(
                    buttonColor: ocean,
                    textColor: snow,
                    buttonText: 'Upload Document'),
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
                onTap: () => {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CreateClassCategory(
                            classTemplate: widget.classTemplate,
                          )))
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
            'Attach documents to the virtual class',
            style: logInPageTitleH3,
            textAlign: TextAlign.center,
          )),
    ),
  );
}
