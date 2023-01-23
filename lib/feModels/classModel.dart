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
  String classWhatToExpect;
  String classUserRequirements;
  String classImage;
  ClassType classType;
  String classLocation;
  double classRating;
  int classReview;
  double classPrice;
  String classTrainer;
  String classTrainerFirstName;
  String classTrainerUsername;
  bool classLiked;
  List<Schedule> classTimes;
  String trainerImageUrl;
  late List<String> classCategories;

  Class({
    required this.className,
    required this.classDescription,
    required this.classWhatToExpect,
    required this.classUserRequirements,
    required this.classImage,
    required this.classType,
    required this.classLocation,
    required this.classRating,
    required this.classReview,
    required this.classPrice,
    required this.classLiked,
    required this.classTimes,

    //Trainer Info
    required this.classTrainer,
    required this.trainerImageUrl,
    required this.classTrainerFirstName,
    required this.classTrainerUsername,
  });
}

List<Class> classList = [
  Class(
    className:
        "Youth Tennis Fundraiser Program held by the Sick Kids Cancer Society",
    classDescription:
        "Students (ages 7-10) should be shaping their skills in becoming more fundamentally sound in movement and technique to handle more advanced play on utilizing a larger court space. Students at this level can rally, and will begin to experiment adding different dimensions to their game: consistency, directional control, spin, and depth. Prior to graduating from Level 1, Orange players should be able to play the game demonstrating technical and tactical fundamentals. ",
    classWhatToExpect:
        'Sessions will be running from 9:00am to 12:00pm every Sunday for the next 5 weeks.\n\n' +
            'One to one training sessions with Roger Federer himself includes: Rallying with the Tennis legend, warming up, participating in an actual class, and cooling down with Roger and his world class coaches.\n\n' +
            'The last week of this program will be a snake style tournament featuring all class participants. \n\n' +
            'All proceeds will be going to the Sick Kids Canada Cancer Society.',
    classUserRequirements: 'A tennis racket and appropriate tennis attire!',
    classImage:
        "https://photo-assets.usopen.org/images/pics/large/f_USTA1030667_20180828_Day2_GE1_4416.jpg",
    classType: ClassType.solo,
    classLocation: "Toronto, Ontario",
    classRating: 4.5,
    classReview: 40,
    classPrice: 250,
    classTrainer: "Roger Federer",
    classTrainerFirstName: 'Roger',
    classTrainerUsername: 'realrogerfreder',
    classLiked: true,
    classTimes: [],
    trainerImageUrl:
        'https://cdn.britannica.com/57/183257-050-0BA11B4B/Roger-Federer-2012.jpg',
  ),
  Class(
    className: "For people who think crossfit is valid",
    classDescription: "Bullshit sudden description",
    classWhatToExpect: '',
    classUserRequirements: '',
    classImage:
        "https://crossfitoxygen.com.au/wp-content/uploads/2020/08/rsz_warm_up_photo_-1.jpg",
    classType: ClassType.group,
    classLocation: "Oakville, Ontario",
    classRating: 3,
    classReview: 10,
    classPrice: 50,
    classTrainer: "David Goggins",
    classTrainerFirstName: 'David',
    classTrainerUsername: 'davidgoggins',
    classLiked: false,
    classTimes: [],
    trainerImageUrl:
        'https://image.cnbcfm.com/api/v1/image/105830788-1554303699103headshot.jpg?v=1554929480&w=1600&h=900',
  ),
  Class(
    className: "Assholes who take Martial Arts",
    classDescription: "Bullshit sudden description",
    classWhatToExpect: '',
    classUserRequirements: '',
    classImage:
        "https://us.venumtrainingcamp.com/wp-content/uploads/2019/03/VENUM_PAGE_DISCIPLINES_MOBILE_1500px_08.jpg",
    classType: ClassType.group,
    classLocation: "Toronto, Ontario",
    classRating: 4,
    classReview: 40,
    classPrice: 600,
    classTrainer: "Conor McGregor",
    classTrainerFirstName: 'Conor',
    classTrainerUsername: 'thenotoriousmma',
    classLiked: false,
    classTimes: [],
    trainerImageUrl:
        'https://media.gq.com/photos/569fe8b3e70a31b77be3e518/16:9/w_2560%2Cc_limit/how-I-got-my-body-gq-0216-3.jpg',
  ),
  Class(
    className: "Is table tennis even a real sport?",
    classDescription: "Bullshit sudden description",
    classWhatToExpect: '',
    classUserRequirements: '',
    classImage: "https://img1.wsimg.com/isteam/stock/V99bd7",
    classType: ClassType.solo,
    classLocation: "Milton, Ontario",
    classRating: 4.2,
    classReview: 12,
    classPrice: 55,
    classTrainer: "King TTennis",
    classTrainerFirstName: 'King',
    classTrainerUsername: 'kttennis',
    classLiked: false,
    classTimes: [],
    trainerImageUrl:
        'https://cdn.vox-cdn.com/thumbor/lo08IC017KpKNNeTiO4Jq8cHhI4=/0x0:3932x2768/1400x1400/filters:focal(851x188:1479x816):format(jpeg)/cdn.vox-cdn.com/uploads/chorus_image/image/50322455/586904530.0.jpg',
  ),
  Class(
    className: "Yoga with PUPPIES",
    classDescription: "Bullshit sudden description",
    classWhatToExpect: '',
    classUserRequirements: '',
    classImage:
        "https://www.familyfuncanada.com/toronto/files/2022/03/puppy-yoga-yoga-kawa.jpg",
    classType: ClassType.virtual,
    classLocation: "Toronto, Ontario",
    classRating: 4.7,
    classReview: 23,
    classPrice: 60,
    classTrainer: "Kimberly Wang",
    classTrainerFirstName: 'Kimberly',
    classTrainerUsername: 'kimwang',
    classLiked: true,
    classTimes: [],
    trainerImageUrl:
        'https://media.herworld.com/public/2022/02/yoga-poses-practise-self-love.jpg?compress=true&quality=80&w=1080&dpr=2.0',
  ),
  Class(
    className: "Imagine running as fast as me?",
    classDescription: "Bullshit sudden description",
    classWhatToExpect: '',
    classUserRequirements: '',
    classImage:
        "https://dashsprintclub.com/wp-content/uploads/2018/12/running-class-1.jpg",
    classType: ClassType.solo,
    classLocation: "London, Ontario",
    classRating: 4,
    classReview: 40,
    classPrice: 140,
    classTrainer: "Usain Bolt",
    classTrainerFirstName: 'Usain',
    classTrainerUsername: 'bolt',
    classLiked: false,
    classTimes: [],
    trainerImageUrl: 'https://wallpapercave.com/wp/mpBaKqa.jpg',
  ),
  Class(
    className: "Get over your Ex!",
    classDescription: "Bullshit sudden description",
    classWhatToExpect: '',
    classUserRequirements: '',
    classImage:
        "https://cdn.lifehack.org/wp-content/uploads/2013/06/bodybuilding-tips.jpg",
    classType: ClassType.solo,
    classLocation: "Vaughn, Ontario",
    classRating: 3.8,
    classReview: 20,
    classPrice: 40,
    classTrainer: "Jason Smith",
    classTrainerFirstName: 'Jason',
    classTrainerUsername: 'jaysmith33',
    classLiked: false,
    classTimes: [],
    trainerImageUrl:
        'https://c0.wallpaperflare.com/preview/126/815/585/weight-person-watch-gym.jpg',
  ),
];
