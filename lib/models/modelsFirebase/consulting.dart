class Consulting {
  String? id, consultingText;
  String ownerConsultingId = '';
  String? consultingResponse;

  Consulting(this.consultingText, this.ownerConsultingId);

  toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['consultingText'] = consultingText;
    map['ownerConsultingId'] = ownerConsultingId;
    return map;
  }

  Consulting.fromMap(Map map) {
    id = map['id'];
    consultingText = map['consultingText'];
    ownerConsultingId = map['ownerConsultingId'];
    consultingResponse = map['consultingResponse'];
  }
}
