class ProgressImagesModel {
  ProgressImagesModel({
    this.status,
    this.responseCode,
    this.message,
    this.data,
  });

  ProgressImagesModel.fromJson(dynamic json) {
    status = json['Status'];
    responseCode = json['ResponseCode'];
    message = json['Message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(ProgressImageData.fromJson(v));
      });
    }
  }

  bool? status;
  int? responseCode;
  String? message;
  List<ProgressImageData>? data;

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

class ProgressImageData {
  ProgressImageData({
    this.date,
    this.weight,
    this.weightUnit,
    this.height,
    this.heightUnit,
    this.frontImage,
    this.sideImage,
    this.backImage,
  });

  ProgressImageData.fromJson(dynamic json) {
    date = json['date'];
    weight = json['weight'];
    weightUnit = json['weightUnit'];
    height = json['height'];
    heightUnit = json['heightUnit'];
    frontImage = json['front_image'];
    sideImage = json['side_image'];
    backImage = json['back_image'];
  }

  String? date;
  String? weight;
  String? weightUnit;
  String? height;
  String? heightUnit;
  String? frontImage;
  String? sideImage;
  String? backImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['date'] = date;
    map['weight'] = weight;
    map['weightUnit'] = weightUnit;
    map['height'] = height;
    map['heightUnit'] = heightUnit;
    map['front_image'] = frontImage;
    map['side_image'] = sideImage;
    map['back_image'] = backImage;
    return map;
  }
}
