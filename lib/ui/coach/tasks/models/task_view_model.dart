class TaskViewModel {
  TaskViewModel({
    this.status,
    this.message,
    this.responseCode,
    this.data,
  });

  TaskViewModel.fromJson(dynamic json) {
    status = json['Status'];
    message = json['Message'];
    responseCode = json['ResponseCode'];
    data = json['data'] != null ? TaskViewData.fromJson(json['data']) : null;
  }

  bool? status;
  String? message;
  int? responseCode;
  TaskViewData? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Status'] = status;
    map['Message'] = message;
    map['ResponseCode'] = responseCode;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }
}

class TaskViewData {
  TaskViewData({
    this.id,
    this.coach,
    this.title,
    this.description,
    this.days,
    this.time,
  });

  TaskViewData.fromJson(dynamic json) {
    id = json['id'];
    coach = json['coach'];
    title = json['title'];
    description = json['description'];
    days = json['days'];
    time = json['time'];
  }

  String? id;
  String? coach;
  String? title;
  String? description;
  String? days;
  String? time;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['coach'] = coach;
    map['title'] = title;
    map['description'] = description;
    map['days'] = days;
    map['time'] = time;
    return map;
  }
}
