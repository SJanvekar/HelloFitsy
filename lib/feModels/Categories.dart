class Category {
  final String categoryName;
  final String categoryImage;
  bool categoryLiked;

  Category(
      {required this.categoryName,
      required this.categoryImage,
      required this.categoryLiked});
}

List<Category> Interests = [];
List<Category> trainerInterests = [];

List<Category> categoriesList = [
  Category(
      categoryName: "Physique",
      categoryImage: "assets/categories/weightTraining.png",
      categoryLiked: false),
  Category(
      categoryName: "Conditioning",
      categoryImage: "assets/categories/conditioning.png",
      categoryLiked: false),
  Category(
      categoryName: "Flexibility",
      categoryImage: "assets/categories/flexibility.png",
      categoryLiked: false),
  Category(
      categoryName: "Lifestyle",
      categoryImage: "assets/categories/lifestyle.png",
      categoryLiked: false),
  Category(
      categoryName: "Badminton",
      categoryImage: "assets/categories/badminton.png",
      categoryLiked: false),
  Category(
      categoryName: "Baseball",
      categoryImage: "assets/categories/baseball.png",
      categoryLiked: false),
  Category(
      categoryName: "Basketball",
      categoryImage: "assets/categories/basketball.png",
      categoryLiked: false),
  Category(
      categoryName: "Boxing",
      categoryImage: "assets/categories/boxing.png",
      categoryLiked: false),
  Category(
      categoryName: "Cricket",
      categoryImage: "assets/categories/cricket.png",
      categoryLiked: false),
  Category(
      categoryName: "Crossfit",
      categoryImage: "assets/categories/crossfit.png",
      categoryLiked: false),
  Category(
      categoryName: "Cycling",
      categoryImage: "assets/categories/cycling.png",
      categoryLiked: false),
  Category(
      categoryName: "Football",
      categoryImage: "assets/categories/football.png",
      categoryLiked: false),
  Category(
      categoryName: "Golf",
      categoryImage: "assets/categories/golf.png",
      categoryLiked: false),
  Category(
      categoryName: "Gymnastics",
      categoryImage: "assets/categories/gymnastics.png",
      categoryLiked: false),
  Category(
      categoryName: "Hockey",
      categoryImage: "assets/categories/hockey.png",
      categoryLiked: false),
  Category(
      categoryName: "Mixed Martial Arts",
      categoryImage: "assets/categories/mma.png",
      categoryLiked: false),
  Category(
      categoryName: "Rugby",
      categoryImage: "assets/categories/rugby.png",
      categoryLiked: false),
  Category(
      categoryName: "Running",
      categoryImage: "assets/categories/running.png",
      categoryLiked: false),
  Category(
      categoryName: "Soccer",
      categoryImage: "assets/categories/soccer.png",
      categoryLiked: false),
  Category(
      categoryName: "Table Tennis",
      categoryImage: "assets/categories/tabletennis.png",
      categoryLiked: false),
  Category(
      categoryName: "Tennis",
      categoryImage: "assets/categories/tennis.png",
      categoryLiked: false),
  Category(
      categoryName: "Track & Field",
      categoryImage: "assets/categories/trackandfield.png",
      categoryLiked: false),
  Category(
      categoryName: "Volleyball",
      categoryImage: "assets/categories/volleyball.png",
      categoryLiked: false),
  Category(
      categoryName: "Weight Lifting",
      categoryImage: "assets/categories/competitveweightlifting.png",
      categoryLiked: false),
];
