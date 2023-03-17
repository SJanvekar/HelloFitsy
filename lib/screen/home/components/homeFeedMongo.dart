import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart';

Future<List<Map<String, dynamic>>> fetchClasses() async {
  final db = await Db.create('mongodb://localhost:27017/classes');
  await db.open();
  final coll = db.collection('classes');
  final cursor = await coll.find();
  final classesList = await cursor.toList();
  await db.close();
  return classesList;
}

class ClassesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Classes'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchClasses(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          if (snapshot.hasData) {
            final classesList = snapshot.data!;
            return ListView.builder(
              itemCount: classesList.length,
              itemBuilder: (context, index) {
                final classData = classesList[index];
                return ListTile(
                  title: Text(classData['className']),
                  subtitle: Text(classData['description']),
                );
              },
            );
          }
          return Text('Error fetching classes');
        },
      ),
    );
  }
}
