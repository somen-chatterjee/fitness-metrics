class WellnessChartModel {
  WellnessChartModel({
    this.status,
    this.responseCode,
    this.message,
    this.data,
  });

  WellnessChartModel.fromJson(dynamic json) {
    status = json['Status'];
    responseCode = json['ResponseCode'];
    message = json['Message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(WellnessData.fromJson(v));
      });
    }
  }

  bool? status;
  int? responseCode;
  String? message;
  List<WellnessData>? data;

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

class WellnessData {
  WellnessData({
    this.id,
    this.athlete,
    this.sleep,
    this.stress,
    this.fatigue,
    this.muscleSoreness,
    this.rpe,
    this.date,
  });

  WellnessData.fromJson(dynamic json) {
    id = json['id'];
    athlete = json['athlete'];
    sleep = json['sleep'];
    stress = json['stress'];
    fatigue = json['fatigue'];
    muscleSoreness = json['muscle_soreness'];
    rpe = json['rpe'];
    date = json['date'];
  }

  dynamic id;
  dynamic athlete;
  dynamic sleep;
  dynamic stress;
  dynamic fatigue;
  dynamic muscleSoreness;
  dynamic rpe;
  dynamic date;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['athlete'] = athlete;
    map['sleep'] = sleep;
    map['stress'] = stress;
    map['fatigue'] = fatigue;
    map['muscle_soreness'] = muscleSoreness;
    map['rpe'] = rpe;
    map['date'] = date;
    return map;
  }
}
