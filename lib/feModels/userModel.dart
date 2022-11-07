import 'dart:ffi';

class User {
  late String userID;
  bool isActive;
  String userType;
  late String profileImageUrl;
  String firstName;
  String lastName;
  String userName;
  String userEmail;
  String password;
  late List<String> likedCategories;
  late List<String> likedClasses;
  late List<String> classHistory;
  late List<String> following;
  late List<String> followers;

  User({
    required this.isActive,
    required this.userType,
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.userEmail,
    required this.password,
  });
}
