import 'dart:ffi';

class Class {
  String className;
  String classImage;
  String classType;
  String classLocation;
  double classRating;
  int classReview;
  int classPrice;
  String classTrainer;
  bool classLiked;

  Class(
      {required this.className,
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
    className: "Yute Tennis Summer Program",
    classImage: "assets/images/egTennisClass.jpg",
    classType: "Solo",
    classLocation: "Toronto, Ontario",
    classRating: 4.5,
    classReview: 40,
    classPrice: 250,
    classTrainer: "Roger Federer",
    classLiked: true,
  ),
  Class(
    className: "For people who think crossfit is valid",
    classImage: "assets/images/egCFClass.jpg",
    classType: "Group",
    classLocation: "Oakville, Ontario",
    classRating: 3,
    classReview: 10,
    classPrice: 50,
    classTrainer: "David Goggins",
    classLiked: false,
  ),
  Class(
    className: "Assholes who take Martial Arts",
    classImage: "assets/images/egMMAClass.jpg",
    classType: "Group",
    classLocation: "Toronto, Ontario",
    classRating: 4.5,
    classReview: 40,
    classPrice: 250,
    classTrainer: "Conor McGregor",
    classLiked: false,
  ),
  Class(
    className: "Is table tennis even a real sport?",
    classImage: "assets/images/egTableTennisClass.jpg",
    classType: "Solo",
    classLocation: "Milton, Ontario",
    classRating: 4.5,
    classReview: 40,
    classPrice: 250,
    classTrainer: "Chinese Legend",
    classLiked: false,
  ),
  Class(
    className: "How many calories do you think Yoga really burns?",
    classImage: "assets/images/egYogaClass.jpg",
    classType: "Virtual",
    classLocation: "Toronto, Ontario",
    classRating: 4.5,
    classReview: 40,
    classPrice: 250,
    classTrainer: "Roger Federer",
    classLiked: true,
  ),
  Class(
    className: "Imagine running?",
    classImage: "assets/images/egRunningClass.jpg",
    classType: "Solo",
    classLocation: "Toronto, Ontario",
    classRating: 4.5,
    classReview: 40,
    classPrice: 250,
    classTrainer: "Roger Federer",
    classLiked: false,
  ),
  Class(
    className: "For Juice Heads that can't get over their Ex",
    classImage: "assets/images/egPhysiqueClass.jpg",
    classType: "Solo",
    classLocation: "Toronto, Ontario",
    classRating: 4.5,
    classReview: 40,
    classPrice: 250,
    classTrainer: "Roger Federer",
    classLiked: false,
  ),
];
