class MeasurementChartModel {
  MeasurementChartModel({
    this.status,
    this.responseCode,
    this.message,
    this.data,
  });

  MeasurementChartModel.fromJson(dynamic json) {
    status = json['Status'];
    responseCode = json['ResponseCode'];
    message = json['Message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(MeasurementData.fromJson(v));
      });
    }
  }

  bool? status;
  int? responseCode;
  String? message;
  List<MeasurementData>? data;

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

class MeasurementData {
  MeasurementData({
    this.id,
    this.athlete,
    this.chest,
    this.armRight,
    this.armLight,
    this.thighRight,
    this.thighLight,
    this.hips1,
    this.hips2,
    this.abs,
    this.calves,
    this.date,
  });

  MeasurementData.fromJson(dynamic json) {
    id = json['id'];
    athlete = json['athlete'];
    chest = json['chest'];
    armRight = json['armRight'];
    armLight = json['armLight'];
    thighRight = json['thighRight'];
    thighLight = json['thighLight'];
    hips1 = json['hips_1'];
    hips2 = json['hips_2'];
    abs = json['abs'];
    calves = json['calves'];
    date = json['date'];
  }

  dynamic id;
  dynamic athlete;
  dynamic chest;
  dynamic armRight;
  dynamic armLight;
  dynamic thighRight;
  dynamic thighLight;
  dynamic hips1;
  dynamic hips2;
  dynamic abs;
  dynamic calves;
  dynamic date;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['athlete'] = athlete;
    map['chest'] = chest;
    map['armRight'] = armRight;
    map['armLight'] = armLight;
    map['thighRight'] = thighRight;
    map['thighLight'] = thighLight;
    map['hips_1'] = hips1;
    map['hips_2'] = hips2;
    map['abs'] = abs;
    map['calves'] = calves;
    map['date'] = date;
    return map;
  }
}
