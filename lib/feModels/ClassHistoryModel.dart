enum ClassType { Solo, Group, Virtual }

class ClassHistory {
  String userName;
  int amountTaken;
  String classImageUrl;
  String className;
  ClassType classType;
  String classLocation;
  String classTrainer;
  String trainerFirstName;
  String trainerLastName;
  String trainerImageUrl;

  ClassHistory({
    required this.userName,
    required this.amountTaken,
    required this.classImageUrl,
    required this.className,
    required this.classType,
    required this.classLocation,

    //Trainer Info
    required this.classTrainer,
    required this.trainerImageUrl,
    required this.trainerFirstName,
    required this.trainerLastName,
  });
}
