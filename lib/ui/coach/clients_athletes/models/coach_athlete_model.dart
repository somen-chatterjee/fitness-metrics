import 'package:fitness_metrics/ui/coach/clients_athletes/models/client_dashboard_model.dart';

class CoachAthleteModel {
  CoachAthleteModel({
    this.status,
    this.responseCode,
    this.message,
    this.data,
    this.currentPage,
    this.lastPage,
    this.total,
  });

  CoachAthleteModel.fromJson(dynamic json) {
    status = json['Status'];
    responseCode = json['ResponseCode'];
    message = json['Message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Athlete.fromJson(v));
      });
    }
    currentPage = json['current_page'];
    lastPage = json['last_page'];
    total = json['total'];
  }

  bool? status;
  int? responseCode;
  String? message;
  List<Athlete>? data;
  int? currentPage;
  int? lastPage;
  int? total;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Status'] = status;
    map['ResponseCode'] = responseCode;
    map['Message'] = message;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    map['current_page'] = currentPage;
    map['last_page'] = lastPage;
    map['total'] = total;
    return map;
  }
}
