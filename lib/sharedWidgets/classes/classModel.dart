import 'dart:ffi';

enum ClassType { solo, group, virtual }

class Class {
  String className;
  String classDescription;
  String classImage;
  ClassType classType;
  String classLocation;
  double classRating;
  double classReview;
  double classPrice;
  String classTrainer;
  bool classLiked;

  Class(
      {required this.className,
      required this.classDescription,
      required this.classImage,
      required this.classType,
      required this.classLocation,
      required this.classRating,
      required this.classReview,
      required this.classPrice,
      required this.classTrainer,
      required this.classLiked});
}

List<Class> classList = [
  Class(
    className: "Yute Tennis Summer Fundraiser Program",
    classDescription: "Bullshit sudden description",
    classImage: "assets/categories/CategoryPhyisque.png",
    classType: ClassType.solo,
    classLocation: "Toronto, Ontario",
    classRating: 4.5,
    classReview: 40,
    classPrice: 250,
    classTrainer: "Roger Federer",
    classLiked: true,
  ),
  Class(
    className: "For people who think crossfit is valid",
    classDescription: "Bullshit sudden description",
    classImage: "assets/images/egCFClass.jpg",
    classType: ClassType.group,
    classLocation: "Oakville, Ontario",
    classRating: 3,
    classReview: 10,
    classPrice: 50,
    classTrainer: "David Goggins",
    classLiked: false,
  ),
  Class(
    className: "Assholes who take Martial Arts",
    classDescription: "Bullshit sudden description",
    classImage: "assets/images/egMMAClass.jpg",
    classType: ClassType.group,
    classLocation: "Toronto, Ontario",
    classRating: 4.5,
    classReview: 40,
    classPrice: 250,
    classTrainer: "Conor McGregor",
    classLiked: false,
  ),
  Class(
    className: "Is table tennis even a real sport?",
    classDescription: "Bullshit sudden description",
    classImage: "assets/images/egTableTennisClass.jpg",
    classType: ClassType.solo,
    classLocation: "Milton, Ontario",
    classRating: 4.5,
    classReview: 40,
    classPrice: 250,
    classTrainer: "Chinese Legend",
    classLiked: false,
  ),
  Class(
    className: "How many calories do you think Yoga really burns?",
    classDescription: "Bullshit sudden description",
    classImage: "assets/images/egYogaClass.jpg",
    classType: ClassType.virtual,
    classLocation: "Toronto, Ontario",
    classRating: 4.5,
    classReview: 40,
    classPrice: 250,
    classTrainer: "Roger Federer",
    classLiked: true,
  ),
  Class(
    className: "Imagine running?",
    classDescription: "Bullshit sudden description",
    classImage: "assets/images/egRunningClass.jpg",
    classType: ClassType.solo,
    classLocation: "Toronto, Ontario",
    classRating: 4.5,
    classReview: 40,
    classPrice: 250,
    classTrainer: "Roger Federer",
    classLiked: false,
  ),
  Class(
    className: "For Juice Heads that can't get over their Ex",
    classDescription: "Bullshit sudden description",
    classImage: "assets/images/egPhysiqueClass.jpg",
    classType: ClassType.solo,
    classLocation: "Toronto, Ontario",
    classRating: 4.5,
    classReview: 40,
    classPrice: 250,
    classTrainer: "Roger Federer",
    classLiked: false,
  ),
];
