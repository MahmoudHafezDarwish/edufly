class Noti {
  Noti({
    this.id,
    this.type,
    this.notifiableType,
    this.notifiableId,
   required this.data,
    this.readAt,
    required this.createdAt,
    required this.updatedAt,
  });

  dynamic id;
  dynamic type;
  dynamic notifiableType;
  dynamic notifiableId;
  Data data;
  dynamic readAt;
  String createdAt;
  String updatedAt;

  factory Noti.fromJson(Map<String, dynamic> json) => Noti(
        id: json["id"],
        type: json["type"],
        notifiableType: json["notifiable_type"],
        notifiableId: json["notifiable_id"],
        data: Data.fromJson(json["data"]),
        readAt: json["read_at"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );
}

class Data {
  Data({
    this.id,
    required this.image,
    required this.data,
  });

  dynamic id;
  String image;
  String data;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        image: json["image"],
        data: json["data"],
      );
}
