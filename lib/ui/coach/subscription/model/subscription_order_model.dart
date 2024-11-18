class SubscriptionOrderModel {
  SubscriptionOrderModel({
    this.status,
    this.message,
    this.responseCode,
    this.data,
  });

  SubscriptionOrderModel.fromJson(dynamic json) {
    status = json['Status'];
    message = json['Message'];
    responseCode = json['ResponseCode'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  bool? status;
  String? message;
  int? responseCode;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Status'] = status;
    map['Message'] = message;
    map['ResponseCode'] = responseCode;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }
}

class Data {
  Data({
    this.orderId,
    this.paymentUrl,
  });

  Data.fromJson(dynamic json) {
    orderId = json['orderId'];
    paymentUrl = json['paymentUrl'];
  }

  int? orderId;
  String? paymentUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['orderId'] = orderId;
    map['paymentUrl'] = paymentUrl;
    return map;
  }
}
