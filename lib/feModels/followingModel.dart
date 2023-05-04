import 'dart:ffi';

class Following {
  String followingUserName;
  String userName;
  String follwingFirstName;
  String follwingLastName;
  late String follwingProfileImageURL;
  late String? follwingUserBio;

  Following({
    required this.followingUserName,
    required this.userName,
    required this.follwingFirstName,
    required this.follwingLastName,
    required this.follwingProfileImageURL,
  });
}
