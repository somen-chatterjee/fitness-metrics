
import 'package:fitness_metrics/ui/coach/clients_athletes/models/client_dashboard_model.dart';

class GroupViewModel {
  GroupViewModel({
    this.status,
    this.responseCode,
    this.message,
    this.data,
  });

  GroupViewModel.fromJson(dynamic json) {
    status = json['Status'];
    responseCode = json['ResponseCode'];
    message = json['Message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Athlete.fromJson(v));
      });
    }
  }

  bool? status;
  int? responseCode;
  String? message;
  List<Athlete>? data;

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

