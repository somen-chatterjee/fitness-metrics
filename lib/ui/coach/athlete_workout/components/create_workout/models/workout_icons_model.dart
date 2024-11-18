class WorkoutIconsModel {
  WorkoutIconsModel({
    this.status,
    this.responseCode,
    this.message,
    this.data,
    this.currentPage,
    this.lastPage,
    this.total,
  });

  WorkoutIconsModel.fromJson(dynamic json) {
    status = json['Status'];
    responseCode = json['ResponseCode'];
    message = json['Message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(IconsData.fromJson(v));
      });
    }
    currentPage = json['current_page'];
    lastPage = json['last_page'];
    total = json['total'];
  }

  bool? status;
  int? responseCode;
  String? message;
  List<IconsData>? data;
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

class IconsData {
  IconsData({
    this.id,
    this.name,
    this.icon,
    this.isSelected,
  });

  IconsData.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    icon = json['icon'];
    icon = json['icon'];
    isSelected = false;
  }

  String? id;
  String? name;
  String? icon;
  bool? isSelected;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['icon'] = icon;
    return map;
  }
}
