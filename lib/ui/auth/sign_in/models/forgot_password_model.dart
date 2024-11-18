class ForgotPasswordModels {
  bool? status;
  int? responseCode;
  String? message;
  Data? data;

  ForgotPasswordModels(
      {this.status, this.responseCode, this.message, this.data});

  ForgotPasswordModels.fromJson(Map<String, dynamic> json) {
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
  String? otp;
  int? userId;

  Data({this.otp, this.userId});

  Data.fromJson(Map<String, dynamic> json) {
    otp = json['otp'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['otp'] = otp;
    data['user_id'] = userId;
    return data;
  }
}
