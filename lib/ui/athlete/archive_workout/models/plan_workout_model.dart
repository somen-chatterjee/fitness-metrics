class PlanWorkoutModel {
  bool? status;
  String? message;
  int? responseCode;
  List<PlanWorkoutData>? data;
  int? currentPage;
  int? lastPage;
  int? total;

  PlanWorkoutModel(
      {this.status,
        this.message,
        this.responseCode,
        this.data,
        this.currentPage,
        this.lastPage,
        this.total});

  PlanWorkoutModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    message = json['Message'];
    responseCode = json['ResponseCode'];
    if (json['data'] != null) {
      data = <PlanWorkoutData>[];
      json['data'].forEach((v) {
        data!.add(PlanWorkoutData.fromJson(v));
      });
    }
    currentPage = json['current_page'];
    lastPage = json['last_page'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Status'] = status;
    data['Message'] = message;
    data['ResponseCode'] = responseCode;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['current_page'] = currentPage;
    data['last_page'] = lastPage;
    data['total'] = total;
    return data;
  }
}

class PlanWorkoutData {
  String? id;
  String? name;
  String? icon;
  String? note;
  bool? isSelected;

  PlanWorkoutData({this.id, this.name, this.icon, this.note, this.isSelected});

  PlanWorkoutData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    icon = json['icon'];
    note = json['note'];
    isSelected = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['icon'] = icon;
    data['note'] = note;
    return data;
  }
}
