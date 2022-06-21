class CourseModel {
   String name;
  String description;
  String university;
  String noOfCource;
  String tag1;
  String tag2;
  bool isFavoruit = false;
  bool addToCart  ;

  CourseModel(
      {required this.name,
      required this.description,
      required this.noOfCource,
      required this.university,
      required this.tag1,
      required this.tag2,
      required this.isFavoruit,this.addToCart = false});
}

class CourseList {
  static List<CourseModel> list = [
    CourseModel(
        name: "علوم أول ابتدائي",
        description:
            "جميع دروس المنهج بحسب نظام الثلاثة فصول, بوربوينت مميز خاص لكل درس بالمنهج.فيديو لكل درس داخل البوربوينت.",
        university: "الفصل الأول",
        noOfCource: " 8 دروس",
        tag1: "السعر 99",
        tag2: "ر.س", isFavoruit: true ,addToCart: true
    ),
    CourseModel(
        name: "علوم أول ابتدائي",
        description:
            "جميع دروس المنهج بحسب نظام الثلاثة فصول, بوربوينت مميز خاص لكل درس بالمنهج.فيديو لكل درس داخل البوربوينت.",
        university: "الفصل الثاني",
        noOfCource: " 16 دروس",
        tag1: "السعر 99",
        tag2: "ر.س", isFavoruit: false,addToCart: false),
    CourseModel(
        name: "علوم ثاني ابتدائي",
        description:
            "جميع دروس المنهج بحسب نظام الثلاثة فصول, بوربوينت مميز خاص لكل درس بالمنهج.فيديو لكل درس داخل البوربوينت.",
        university: "الفصل الأول",
        noOfCource: " 12 دروس",
        tag1: "السعر 99",
        tag2: "ر.س", isFavoruit: true,addToCart: false),
    CourseModel(
        name: "علوم ثاني ابتدائي",
        description:
            "جميع دروس المنهج بحسب نظام الثلاثة فصول, بوربوينت مميز خاص لكل درس بالمنهج.فيديو لكل درس داخل البوربوينت.",
        university: "الفصل الثاني",
        noOfCource: " 10 دروس",
        tag1: "السعر 99",
        tag2: "ر.س", isFavoruit: false,addToCart: false),

  ];
}
