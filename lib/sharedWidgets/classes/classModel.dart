import 'dart:ffi';

enum ClassType { solo, group, virtual }

class Schedule {
  Set<DateTime> dates;
  DateTime startTime;
  DateTime endTime;

  Schedule({
    required this.dates,
    required this.startTime,
    required this.endTime,
  });
}

class Class {
  String className;
  String classDescription;
  String classImage;
  ClassType classType;
  String classLocation;
  double classRating;
  int classReview;
  double classPrice;
  String classTrainer;
  bool classLiked;
  List<Schedule> classTimes;
  String trainerImageUrl;

  Class({
    required this.className,
    required this.classDescription,
    required this.classImage,
    required this.classType,
    required this.classLocation,
    required this.classRating,
    required this.classReview,
    required this.classPrice,
    required this.classTrainer,
    required this.classLiked,
    required this.classTimes,
    required this.trainerImageUrl,
  });
}

List<Class> classList = [
  Class(
    className: "Yute Tennis Summer Fundraiser Program",
    classDescription: "Bullshit sudden description",
    classImage:
        "https://tennisdirectory.tenxpro.com/wp-content/uploads/2017/10/Inspire-Tennis-Sydney-Junior-Tennis-Hot-Shots-1-1080x600.jpg",
    classType: ClassType.solo,
    classLocation: "Toronto, Ontario",
    classRating: 4.5,
    classReview: 40,
    classPrice: 250,
    classTrainer: "Roger Federer",
    classLiked: true,
    classTimes: [],
    trainerImageUrl:
        'https://sportshub.cbsistatic.com/i/r/2022/09/15/406ba7f5-4022-474c-8e8d-cf180d2c1a16/thumbnail/1200x675/4f6c21a290afee7000572827cb85486d/roger-federer-getty.png',
  ),
  Class(
    className: "For people who think crossfit is valid",
    classDescription: "Bullshit sudden description",
    classImage:
        "https://crossfitoxygen.com.au/wp-content/uploads/2020/08/rsz_warm_up_photo_-1.jpg",
    classType: ClassType.group,
    classLocation: "Oakville, Ontario",
    classRating: 3,
    classReview: 10,
    classPrice: 50,
    classTrainer: "David Goggins",
    classLiked: false,
    classTimes: [],
    trainerImageUrl:
        'https://www.ahigherbranch.com/wp-content/uploads/2019/06/David-Goggins.jpg',
  ),
  Class(
    className: "Assholes who take Martial Arts",
    classDescription: "Bullshit sudden description",
    classImage:
        "https://us.venumtrainingcamp.com/wp-content/uploads/2019/03/VENUM_PAGE_DISCIPLINES_MOBILE_1500px_08.jpg",
    classType: ClassType.group,
    classLocation: "Toronto, Ontario",
    classRating: 4,
    classReview: 40,
    classPrice: 600,
    classTrainer: "Conor McGregor",
    classLiked: false,
    classTimes: [],
    trainerImageUrl:
        'https://cdn.vox-cdn.com/thumbor/ejpN_BZhy3DbFitLKLPkPNB5tc0=/1400x1050/filters:format(jpeg)/cdn.vox-cdn.com/uploads/chorus_asset/file/24070976/1399272630.jpg',
  ),
  Class(
    className: "Is table tennis even a real sport?",
    classDescription: "Bullshit sudden description",
    classImage: "https://img1.wsimg.com/isteam/stock/V99bd7",
    classType: ClassType.solo,
    classLocation: "Milton, Ontario",
    classRating: 4.2,
    classReview: 12,
    classPrice: 55,
    classTrainer: "Chinese Legend",
    classLiked: false,
    classTimes: [],
    trainerImageUrl:
        'https://media.istockphoto.com/photos/portrait-of-chinese-personal-trainer-in-gym-picture-id1018043738?k=20&m=1018043738&s=170667a&w=0&h=D73Bdou7PZFE_ASJ1LOyOij4KHk1zRwOGCqAZnS5cqg=',
  ),
  Class(
    className: "Yoga with PUPPIES",
    classDescription: "Bullshit sudden description",
    classImage:
        "https://www.familyfuncanada.com/toronto/files/2022/03/puppy-yoga-yoga-kawa.jpg",
    classType: ClassType.virtual,
    classLocation: "Toronto, Ontario",
    classRating: 4.7,
    classReview: 23,
    classPrice: 60,
    classTrainer: "Kimberly Franques",
    classLiked: true,
    classTimes: [],
    trainerImageUrl:
        'https://www.wellnessliving.com/blog/wp-content/uploads/2019/06/Hiring-Yoga-Instructors.jpg',
  ),
  Class(
    className: "Imagine running?",
    classDescription: "Bullshit sudden description",
    classImage:
        "https://dashsprintclub.com/wp-content/uploads/2018/12/running-class-1.jpg",
    classType: ClassType.solo,
    classLocation: "London, Ontario",
    classRating: 4,
    classReview: 40,
    classPrice: 140,
    classTrainer: "Mo Farah",
    classLiked: false,
    classTimes: [],
    trainerImageUrl:
        'https://metro.co.uk/wp-content/uploads/2022/07/SEC_114286993.jpg?quality=90&strip=all',
  ),
  Class(
    className: "Get over your Ex!",
    classDescription: "Bullshit sudden description",
    classImage:
        "https://cdn.lifehack.org/wp-content/uploads/2013/06/bodybuilding-tips.jpg",
    classType: ClassType.solo,
    classLocation: "Vaughn, Ontario",
    classRating: 3.8,
    classReview: 20,
    classPrice: 40,
    classTrainer: "Jason Smith",
    classLiked: false,
    classTimes: [],
    trainerImageUrl:
        'https://images.ctfassets.net/psi7gc0m4mjv/6vL20yPWnuuJNvPtnG5KkO/788d1e4e39fccdb3abfed21fd465f2e4/master_personal_trainer_mobile_hero_image_2x.jpg',
  ),
];
