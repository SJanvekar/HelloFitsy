import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RatingPopup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPopupSurface(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: EdgeInsets.all(10),
                child: Icon(
                  Icons.close,
                  size: 15,
                  color: Colors.grey,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'Option',
                style: TextStyle(
                  color: CupertinoColors.lightBackgroundGray,
                  fontSize: 18,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'How was your class?',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'Subheader 1 (Dynamic Text)',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'Subheader 2 (Dynamic Text)',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            Center(
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: CupertinoColors.systemGrey,
                    width: 2,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network(
                    'https://encrypted-tbn3.gstatic.com/licensed-image?q=tbn:ANd9GcTSzsa68GeFo6OZUyJlXvNGMEdxTSaFfphyzJeD5zcTcU25s66kYVQfpSGsqMzJ4gNWxiXhayaWZgX8n3M',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  for (int i = 1; i <= 5; i++)
                    GestureDetector(
                      onTap: () {
                        // Handle star selection here
                      },
                      child: Icon(
                        i <= 3 ? Icons.star : Icons.star_border,
                        size: 30,
                        color: Colors.yellow,
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'Rating: Amazing',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: CupertinoTextField(
                placeholder: 'Start typing here',
                placeholderStyle: TextStyle(color: Colors.grey),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: CupertinoColors.systemGrey,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            CupertinoButton(
              onPressed: () {
                // Handle submit button click
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
