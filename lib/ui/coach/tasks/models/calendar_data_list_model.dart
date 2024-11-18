class CalendarDataListModel {
  CalendarDataListModel({
      this.status, 
      this.responseCode, 
      this.message, 
      this.data,});

  CalendarDataListModel.fromJson(dynamic json) {
    status = json['Status'];
    responseCode = json['ResponseCode'];
    message = json['Message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(CalendarData.fromJson(v));
      });
    }
  }
  bool? status;
  int? responseCode;
  String? message;
  List<CalendarData>? data;

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

class CalendarData {
  CalendarData({
      this.id, 
      this.dayName, 
      this.status, 
      this.date,});

  CalendarData.fromJson(dynamic json) {
    id = json['id'];
    dayName = json['day_name'];
    status = json['status'];
    date = json['date'];
  }
  String? id;
  String? dayName;
  bool? status;
  String? date;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['day_name'] = dayName;
    map['status'] = status;
    map['date'] = date;
    return map;
  }

}