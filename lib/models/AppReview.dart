import 'Model.dart';

class AppReview extends Model {
  static const String LIKED_KEY = "liked";
  static const String STARS_KEY = "star";
  static const String FEEDBACK_KEY = "feedback";

  bool? liked;
  String? feedback;
  String? star;

  AppReview(
    String id, {
    this.liked,
    this.feedback,
    this.star,
  }) : super(id);

  factory AppReview.fromMap(Map<String, dynamic> map, {required String id}) {
    return AppReview(
      id,
      liked: map[LIKED_KEY],
      feedback: map[FEEDBACK_KEY],
      star: map[STARS_KEY]
    );
  }

  @override
  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      LIKED_KEY: liked,
      FEEDBACK_KEY: feedback,
      STARS_KEY:star
    };
    return map;
  }

  @override
  Map<String, dynamic> toUpdateMap() {
    final map = <String, dynamic>{};
    if (liked != null) map[LIKED_KEY] = liked;
    if (feedback != null) map[FEEDBACK_KEY] = feedback;
    if (star != null) map[STARS_KEY] = star;
    return map;
  }
}
