class SignUpModels {
  int? responseCode;
  String? message;
  bool? status;
  Data? data;

  SignUpModels({this.responseCode, this.message, this.status, this.data});

  SignUpModels.fromJson(Map<String, dynamic> json) {
    responseCode = json['ResponseCode'];
    message = json['Message'];
    status = json['Status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ResponseCode'] = responseCode;
    data['Message'] = message;
    data['Status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? userId;
  String? name;
  String? dateOfBirth;
  String? email;
  String? mobile;
  String? otp;

  Data(
      {this.userId,
        this.name,
        this.dateOfBirth,
        this.email,
        this.mobile,
        this.otp});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    name = json['name'];
    dateOfBirth = json['date_of_birth'];
    email = json['email'];
    mobile = json['mobile'];
    otp = json['otp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['name'] = name;
    data['date_of_birth'] = dateOfBirth;
    data['email'] = email;
    data['mobile'] = mobile;
    data['otp'] = otp;
    return data;
  }
}
