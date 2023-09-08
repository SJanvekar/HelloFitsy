class Following {
  String followingUsername;
  String username;

  Following({required this.followingUsername, required this.username});

  Following.fromJson(Map<String, dynamic> json)
      : followingUsername = json['FollowingUsername'],
        username = json['Username'];

  Map<String, dynamic> toJson() =>
      {'FollowingUsername': followingUsername, 'Username': username};
}
