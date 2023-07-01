import 'dart:ffi';
import 'dart:convert';

enum UserType { Trainee, Trainer }

class User {
  bool isActive;
  UserType userType;
  late String profileImageURL;
  String firstName;
  String lastName;
  String userName;
  late String? userBio;
  String userEmail;
  String password;
  late List<String> categories;
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
    required this.userEmail,
    required this.password,
  });

  //JSON parsers are required to parse arrays of JSON
  User.fromJson(Map<String, dynamic> json)
      : isActive =
            json['IsActive'].toString().toLowerCase() == "true" ? true : false,
        userType = stringToUserType(json['UserType'][0]),
        profileImageURL = json['ProfileImageURL'],
        firstName = json['FirstName'],
        lastName = json['LastName'],
        userName = json['Username'],
        userBio = json['UserBio'],
        userEmail = json['UserEmail'],
        password = json['Password'],
        categories = dyanamicArrayToStringArray(json['Categories']);
  // likedClasses = json['LikedClasses'],
  // classHistory = json['ClassHistory'],
  // following = json['Following'],
  // followers = json['Followers'];

  Map<String, dynamic> toJson() => {
        'IsActive': isActive,
        'UserType': userType.toString(),
        'ProfileImageURL': profileImageURL,
        'FirstName': firstName,
        'LastName': lastName,
        'Username': userName,
        'UserBio': userBio,
        'UserEmail': userEmail,
        'Password': password,
        'Categories': categories,
        // 'LikedClasses': likedClasses,
        // 'ClassHistory': classHistory,
        // 'Following': following,
        // 'Followers': followers
      };
}

//Semi-hardcoded casting from String to ClassType, not optimal but the best I can think of right now
UserType stringToUserType(String string) {
  switch (string) {
    case "Trainee":
      return UserType.Trainee;
    case "Trainer":
      return UserType.Trainer;
    default:
      throw Exception('String to UserType cast failed');
  }
}

List<String> dyanamicArrayToStringArray(List<dynamic> string) {
  List<String> list = [];
  string.forEach((element) {
    list.add(element);
  });
  return list;
}
