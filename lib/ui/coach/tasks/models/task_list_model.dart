class TaskListModel {
  TaskListModel({
    this.status,
    this.message,
    this.responseCode,
    this.data,
  });

  TaskListModel.fromJson(dynamic json) {
    status = json['Status'];
    message = json['Message'];
    responseCode = json['ResponseCode'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(TaskData.fromJson(v));
      });
    }
  }

  bool? status;
  String? message;
  int? responseCode;
  List<TaskData>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Status'] = status;
    map['Message'] = message;
    map['ResponseCode'] = responseCode;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class TaskData {
  TaskData({
    this.id,
    this.coach,
    this.title,
    this.description,
    this.days,
    this.time,
    this.taskStatus,
  });

  TaskData.fromJson(dynamic json) {
    id = json['id'];
    coach = json['coach'];
    title = json['title'];
    description = json['description'];
    days = json['days'];
    time = json['time'];
    taskStatus = json['task_status'];
  }

  String? id;
  String? coach;
  String? title;
  String? description;
  String? days;
  String? time;
  bool? taskStatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['coach'] = coach;
    map['title'] = title;
    map['description'] = description;
    map['days'] = days;
    map['time'] = time;
    map['task_status'] = taskStatus;
    return map;
  }
}
