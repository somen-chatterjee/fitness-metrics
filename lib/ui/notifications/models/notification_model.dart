class NotificationModel {
  NotificationModel({
    this.status,
    this.responseCode,
    this.message,
    this.data,
    this.currentPage,
    this.lastPage,
    this.total,
  });

  NotificationModel.fromJson(dynamic json) {
    status = json['Status'];
    responseCode = json['ResponseCode'];
    message = json['Message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(NotificationData.fromJson(v));
      });
    }
    currentPage = json['current_page'];
    lastPage = json['last_page'];
    total = json['total'];
  }

  bool? status;
  int? responseCode;
  String? message;
  List<NotificationData>? data;
  int? currentPage;
  int? lastPage;
  int? total;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Status'] = status;
    map['ResponseCode'] = responseCode;
    map['Message'] = message;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    map['current_page'] = currentPage;
    map['last_page'] = lastPage;
    map['total'] = total;
    return map;
  }
}

class NotificationData {
  NotificationData({
    this.id,
    this.user,
    this.title,
    this.time,
    this.date,
  });

  NotificationData.fromJson(dynamic json) {
    id = json['id'];
    user = json['user'];
    title = json['title'];
    time = json['time'];
    date = json['date'];
  }

  String? id;
  String? user;
  String? title;
  String? time;
  String? date;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user'] = user;
    map['title'] = title;
    map['time'] = time;
    map['date'] = date;
    return map;
  }
}
