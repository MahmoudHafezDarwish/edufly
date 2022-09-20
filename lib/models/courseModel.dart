class CourseModel {
  String name;
  String description;
  String? highlightCourse;
  String? linkOfCourse;
  String? ownerId;
  String subCategory;
  String noOfCource;
  String price;
  String tag2;
  bool isFavoruit = false;
  bool addToCart;

  CourseModel({
    required this.name,
    required this.description,
    required this.noOfCource,
    required this.subCategory,
    required this.price,
    required this.tag2,
    this.highlightCourse,
    this.linkOfCourse,
    this.ownerId,
    required this.isFavoruit,
    this.addToCart = false,
  });
}

class CourseList {
  static List<CourseModel> list = [
    CourseModel(
        name: "علوم أول ابتدائي",
        description:
            "جميع دروس المنهج بحسب نظام الثلاثة فصول, بوربوينت مميز خاص لكل درس بالمنهج.فيديو لكل درس داخل البوربوينت.",
        subCategory: "الفصل الأول",
        noOfCource: " 8 دروس",
        price: "السعر 99",
        tag2: "ر.س",
        isFavoruit: true,
        addToCart: true),
    CourseModel(
        name: "علوم أول ابتدائي",
        description:
            "جميع دروس المنهج بحسب نظام الثلاثة فصول, بوربوينت مميز خاص لكل درس بالمنهج.فيديو لكل درس داخل البوربوينت.",
        subCategory: "الفصل الثاني",
        noOfCource: " 16 دروس",
        price: "السعر 99",
        tag2: "ر.س",
        isFavoruit: false,
        addToCart: false),
    CourseModel(
        name: "علوم ثاني ابتدائي",
        description:
            "جميع دروس المنهج بحسب نظام الثلاثة فصول, بوربوينت مميز خاص لكل درس بالمنهج.فيديو لكل درس داخل البوربوينت.",
        subCategory: "الفصل الأول",
        noOfCource: " 12 دروس",
        price: "السعر 99",
        tag2: "ر.س",
        isFavoruit: true,
        addToCart: false),
    CourseModel(
        name: "علوم ثاني ابتدائي",
        description:
            "جميع دروس المنهج بحسب نظام الثلاثة فصول, بوربوينت مميز خاص لكل درس بالمنهج.فيديو لكل درس داخل البوربوينت.",
        subCategory: "الفصل الثاني",
        noOfCource: " 10 دروس",
        price: "السعر 99",
        tag2: "ر.س",
        isFavoruit: false,
        addToCart: false),
  ];
}
