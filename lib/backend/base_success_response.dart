class BaseSuccessResponse {
  dynamic responseCode;
  dynamic status; // bool
  dynamic message; // String

  BaseSuccessResponse({this.status, this.message, this.responseCode});

  BaseSuccessResponse.fromJson(Map<String, dynamic> json) {
    responseCode = json['ResponseCode'];
    status = json['Status'];
    message = json['Message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ResponseCode'] = responseCode;
    data['Status'] = status;
    data['Message'] = message;
    return data;
  }
}
