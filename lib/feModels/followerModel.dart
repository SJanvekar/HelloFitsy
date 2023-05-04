import 'dart:ffi';

class Follower {
  String followerUserName;
  String userName;
  String followerFirstName;
  String followerLastName;
  late String followerProfileImageURL;
  late String? followerUserBio;

  Follower({
    required this.followerUserName,
    required this.userName,
    required this.followerFirstName,
    required this.followerLastName,
    required this.followerProfileImageURL,
  });
}
