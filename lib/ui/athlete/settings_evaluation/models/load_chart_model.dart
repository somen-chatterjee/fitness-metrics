class LoadChartModel {
  bool? status;
  int? responseCode;
  String? message;
  Data? data;

  LoadChartModel({this.status, this.responseCode, this.message, this.data});

  LoadChartModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    responseCode = json['ResponseCode'];
    message = json['Message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Status'] = status;
    data['ResponseCode'] = responseCode;
    data['Message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<LoadData>? loadData;
  List<Exercise>? exercise;

  Data({this.loadData, this.exercise});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['load_value'] != null) {
      loadData = <LoadData>[];
      json['load_value'].forEach((v) {
        loadData!.add(LoadData.fromJson(v));
      });
    }
    if (json['exercise'] != null) {
      exercise = <Exercise>[];
      json['exercise'].forEach((v) {
        exercise!.add(Exercise.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (loadData != null) {
      data['load_value'] = loadData!.map((v) => v.toJson()).toList();
    }
    if (exercise != null) {
      data['exercise'] = exercise!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LoadData {
  dynamic total;
  dynamic rmValue;
  String? date;

  LoadData({this.total, this.rmValue, this.date});

  LoadData.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    rmValue = json['rm_value'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    data['rm_value'] = rmValue;
    data['date'] = date;
    return data;
  }
}

class Exercise {
  int? id;
  String? exercise;

  Exercise({this.id, this.exercise});

  Exercise.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    exercise = json['exercise'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['exercise'] = exercise;
    return data;
  }
}
