class ExerciseEditData {
  ExerciseEditData({
    this.status,
    this.responseCode,
    this.message,
    this.data,
  });

  ExerciseEditData.fromJson(dynamic json) {
    status = json['Status'];
    responseCode = json['ResponseCode'];
    message = json['Message'];
    data = json['data'] != null ? EditData.fromJson(json['data']) : null;
  }

  bool? status;
  int? responseCode;
  String? message;
  EditData? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Status'] = status;
    map['ResponseCode'] = responseCode;
    map['Message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }
}

class EditData {
  EditData({
    this.id,
    this.coach,
    this.name,
    this.videoUrl,
    this.note,
  });

  EditData.fromJson(dynamic json) {
    id = json['id'];
    coach = json['coach'];
    name = json['name'];
    videoUrl = json['video_url'];
    note = json['note'];
  }

  String? id;
  String? coach;
  String? name;
  String? videoUrl;
  String? note;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['coach'] = coach;
    map['name'] = name;
    map['video_url'] = videoUrl;
    map['note'] = note;
    return map;
  }
}
