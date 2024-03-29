// ignore: constant_identifier_names
enum UserType { Trainee, Trainer }

class User {
  late String userID;
  bool isActive;
  late UserType userType;
  late String profileImageURL;
  String firstName;
  String lastName;
  String userName;
  late String? userBio;
  late List<String> categories;
  late String? stripeAccountID;
  late String? stripeCustomerID;
  late bool isStripeDetailsSubmitted = false;

  User({
    required this.isActive,
    required this.userType,
    required this.profileImageURL,
    required this.firstName,
    required this.lastName,
    required this.userName,
  });

  //JSON parsers are required to parse arrays of JSON
  User.fromJson(Map<String, dynamic> json)
      : userID = json['_id'],
        isActive =
            json['IsActive'].toString().toLowerCase() == "true" ? true : false,
        userType = stringToUserType(json['UserType'][0]),
        profileImageURL = json['ProfileImageURL'],
        firstName = json['FirstName'],
        lastName = json['LastName'],
        userName = json['Username'],
        userBio = json['UserBio'],
        categories = dyanamicArrayToStringArray(json['Categories']),
        stripeAccountID = json['StripeAccountID'],
        stripeCustomerID = json['StripeCustomerID'];

  Map<String, dynamic> toJson() => {
        '_id': userID,
        'IsActive': isActive,
        'UserType': [userType.toString().split('.')[1]],
        'ProfileImageURL': profileImageURL,
        'FirstName': firstName,
        'LastName': lastName,
        'Username': userName,
        'UserBio': userBio,
        'Categories': categories,
        'StripeAccountID': stripeAccountID,
        'StripeCustomerID': stripeCustomerID
      };
}

//Semi-hardcoded casting from String to UserType, not optimal but the best I can think of right now
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
