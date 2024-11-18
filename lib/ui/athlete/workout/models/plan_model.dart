class PlanModel {
  bool? status;
  String? message;
  int? responseCode;
  List<PlanData>? data;
  int? currentPage;
  int? lastPage;
  int? total;

  PlanModel(
      {this.status,
        this.message,
        this.responseCode,
        this.data,
        this.currentPage,
        this.lastPage,
        this.total});

  PlanModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    message = json['Message'];
    responseCode = json['ResponseCode'];
    if (json['data'] != null) {
      data = <PlanData>[];
      json['data'].forEach((v) {
        data!.add(PlanData.fromJson(v));
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

class PlanData {
  String? id;
  String? name;
  String? startDate;
  String? finishDate;
  int? status;

  PlanData({this.id, this.name, this.startDate, this.finishDate, this.status});

  PlanData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    startDate = json['start_date'];
    finishDate = json['finish_date'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['start_date'] = startDate;
    data['finish_date'] = finishDate;
    data['status'] = status;
    return data;
  }
}
