import 'package:balance/feModels/authModel.dart';

enum UserType { Trainee, Trainer }

class User {
  bool isActive;
  UserType userType;
  late String profileImageURL;
  String firstName;
  String lastName;
  String userName;
  late String? userBio;
  late List<String> categories;
  Auth authUser;

  //TODO: Delete below when done with listSchemaChanges branch
  late List<String> likedClasses;
  late List<String> classHistory;
  late List<String> following;
  late List<String> followers;

  User({
    required this.isActive,
    required this.userType,
    required this.profileImageURL,
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.authUser,
  });
}
