import 'package:fitness_metrics/ui/coach/profile_coach/models/exercises_model.dart';

class SectionExerciseModel {
  SectionExerciseModel({
    this.status,
    this.responseCode,
    this.message,
    this.data,
  });

  SectionExerciseModel.fromJson(dynamic json) {
    status = json['Status'];
    responseCode = json['ResponseCode'];
    message = json['Message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(ExerciseData.fromJson(v));
      });
    }
  }

  bool? status;
  int? responseCode;
  String? message;
  List<ExerciseData>? data;

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

