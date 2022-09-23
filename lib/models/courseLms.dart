import 'package:Design/models/review.dart';

import 'include.dart';

class Course {
  Course({
    required this.id,
    required this.userId,
    required this.categoryId,
    required this.subcategoryId,
    required this.childcategoryId,
    required this.languageId,
    required this.title,
    required this.shortDetail,
    required this.detail,
    required this.requirement,
    required this.price,
    required this.discountPrice,
    required this.day,
    required this.video,
    required this.url,
    required this.featured,
    required this.slug,
    required this.status,
    required this.previewImage,
    required this.videoUrl,
    required this.previewType,
    required this.type,
    this.duration,
    required this.durationType,
    required this.lastActive,
    required this.createdAt,
    required this.updatedAt,
    required this.include,
    required this.whatlearns,
    required this.review,
  });

  int id;
  String userId;
  String categoryId;
  String subcategoryId;
  String childcategoryId;
  String languageId;
  String title;
  String shortDetail;
  String detail;
  String requirement;
  String price;
  String discountPrice;
  String day;
  String video;
  String url;
  String featured;
  String slug;
  String status;
  String previewImage;
  dynamic videoUrl;
  String previewType;
  String type;
  dynamic duration;
  String durationType;
  String lastActive;
  DateTime createdAt;
  DateTime updatedAt;
  List<Include> include;
  List<Include> whatlearns;
  List<Review>? review;

  factory Course.fromJson(Map<String, dynamic> json) => Course(
        id: json["id"],
        userId: json["user_id"],
        categoryId: json["category_id"],
        subcategoryId: json["subcategory_id"],
        childcategoryId: json["childcategory_id"],
        languageId: json["language_id"],
        title: json["title"],
        shortDetail: json["short_detail"],
        detail: json["detail"],
        requirement: json["requirement"],
        price: json["price"] == null ? null : json["price"],
        discountPrice:
            json["discount_price"] == null ? null : json["discount_price"],
        day: json["day"] == null ? null : json["day"],
        video: json["video"] == null ? null : json["video"],
        url: json["url"] == null ? null : json["url"],
        featured: json["featured"],
        slug: json["slug"],
        status: json["status"],
        previewImage:
            json["preview_image"] == null ? null : json["preview_image"],
        videoUrl: json["video_url"],
        previewType: json["preview_type"],
        type: json["type"],
        duration: json["duration"] == null ? null : json["duration"],
        durationType:
            json["duration_type"] == null ? null : json["duration_type"],
        lastActive: json["last_active"] == null ? null : json["last_active"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        include:
            List<Include>.from(json["include"].map((x) => Include.fromJson(x))),
        whatlearns: List<Include>.from(
            json["whatlearns"].map((x) => Include.fromJson(x))),
        review: json["review"] == null
            ? null
            : List<Review>.from(json["review"].map((x) => Review.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "category_id": categoryId,
        "subcategory_id": subcategoryId,
        "childcategory_id": childcategoryId,
        "language_id": languageId,
        "title": title,
        "short_detail": shortDetail,
        "detail": detail,
        "requirement": requirement,
        "price": price == null ? null : price,
        "discount_price": discountPrice == null ? null : discountPrice,
        "day": day == null ? null : day,
        "video": video == null ? null : video,
        "url": url == null ? null : url,
        "featured": featured,
        "slug": slug,
        "status": status,
        "preview_image": previewImage == null ? null : previewImage,
        "video_url": videoUrl,
        "preview_type": previewType,
        "type": type,
        "duration": duration == null ? null : duration,
        "duration_type": durationType == null ? null : durationType,
        "last_active": lastActive == null ? null : lastActive,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "include": List<dynamic>.from(include.map((x) => x.toJson())),
        "whatlearns": List<dynamic>.from(whatlearns.map((x) => x.toJson())),
        "review": List<dynamic>.from(review!.map((x) => x.toJson())),
      };
}

enum PreviewType { URL, VIDEO }

final previewTypeValues =
    EnumValues({"url": PreviewType.URL, "video": PreviewType.VIDEO});

class EnumValues<T> {
  Map<String, T> map= Map();
  Map<T, String> reverseMap= Map();

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
