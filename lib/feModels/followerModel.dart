import 'dart:ffi';

class Follower {
  String followerUsername;
  String username;
  String followerFirstName;
  String followerLastName;
  late String followerProfileImageURL;
  late String? followerUserBio;

  Follower({
    required this.followerUsername,
    required this.username,
    required this.followerFirstName,
    required this.followerLastName,
    required this.followerProfileImageURL,
  });
}
