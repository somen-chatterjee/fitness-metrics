class AthleteBodyDetailsModel {
  bool? status;
  int? responseCode;
  String? message;
  Data? data;

  AthleteBodyDetailsModel(
      {this.status, this.responseCode, this.message, this.data});

  AthleteBodyDetailsModel.fromJson(Map<String, dynamic> json) {
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
  String? userId;
  String? height;
  String? heightUnit;
  String? weight;
  String? weightUnit;
  String? frontImage;
  String? sideImage;
  String? backImage;

  Data(
      {this.userId,
        this.height,
        this.heightUnit,
        this.weight,
        this.weightUnit,
        this.frontImage,
        this.sideImage,
        this.backImage});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    height = json['height'];
    heightUnit = json['heightUnit'];
    weight = json['weight'];
    weightUnit = json['weightUnit'];
    frontImage = json['front_image'];
    sideImage = json['side_image'];
    backImage = json['back_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['height'] = height;
    data['heightUnit'] = heightUnit;
    data['weight'] = weight;
    data['weightUnit'] = weightUnit;
    data['front_image'] = frontImage;
    data['side_image'] = sideImage;
    data['back_image'] = backImage;
    return data;
  }
}
