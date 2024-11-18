class DateTaskListModel {
  DateTaskListModel({
    this.status,
    this.responseCode,
    this.message,
    this.data,
  });

  DateTaskListModel.fromJson(dynamic json) {
    status = json['Status'];
    responseCode = json['ResponseCode'];
    message = json['Message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(DateTaskData.fromJson(v));
      });
    }
  }

  bool? status;
  int? responseCode;
  String? message;
  List<DateTaskData>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Status'] = status;
    map['ResponseCode'] = responseCode;
    map['Message'] = message;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class DateTaskData {
  DateTaskData({
    this.id,
    this.title,
    this.dayName,
    this.description,
    this.time,
    this.date,
  });

  DateTaskData.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    dayName = json['day_name'];
    description = json['description'];
    time = json['time'];
    date = json['date'];
  }

  String? id;
  String? title;
  String? dayName;
  String? description;
  String? time;
  String? date;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['day_name'] = dayName;
    map['description'] = description;
    map['time'] = time;
    map['date'] = date;
    return map;
  }
}
