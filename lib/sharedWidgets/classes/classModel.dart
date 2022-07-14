class Class {
  final String className;
  final String classImage;
  final String classType;
  final String classLocation;
  final String classRating;
  final String classReview;
  final String classPrice;
  final String classTrainer;
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
    className: "Yute Tennis Fundraiser Program",
    classImage: "assets/categories/CategoryPhyisque.png",
    classType: "One-on-one training",
    classLocation: "Toronto, Ontario",
    classRating: "4.5",
    classReview: "40",
    classPrice: "250",
    classTrainer: "Roger Federer",
    classLiked: true,
  ),
];
