class ChartDataModel {
  ChartDataModel({
    this.status,
    this.responseCode,
    this.message,
    this.data,
  });

  ChartDataModel.fromJson(dynamic json) {
    status = json['Status'];
    responseCode = json['ResponseCode'];
    message = json['Message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(ChartData.fromJson(v));
      });
    }
  }

  bool? status;
  int? responseCode;
  String? message;
  List<ChartData>? data;

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

class ChartData {
  ChartData({
    this.id,
    this.athlete,
    this.height,
    this.weight,
    this.frontImage,
    this.sideImage,
    this.backImage,
    this.dayName,
    this.date,
  });

  ChartData.fromJson(dynamic json) {
    id = json['id'];
    athlete = json['athlete'];
    height = json['height'];
    weight = json['weight'];
    frontImage = json['front_image'];
    sideImage = json['side_image'];
    backImage = json['back_image'];
    dayName = json['day_name'];
    date = json['date'];
  }

  String? id;
  String? athlete;
  dynamic height;
  dynamic weight;
  String? frontImage;
  String? sideImage;
  String? backImage;
  String? dayName;
  String? date;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['athlete'] = athlete;
    map['height'] = height;
    map['weight'] = weight;
    map['front_image'] = frontImage;
    map['side_image'] = sideImage;
    map['back_image'] = backImage;
    map['day_name'] = dayName;
    map['date'] = date;
    return map;
  }
}
