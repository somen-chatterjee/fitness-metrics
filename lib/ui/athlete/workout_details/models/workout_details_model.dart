import 'package:flutter/cupertino.dart';

class WorkoutDetailsModel {
  bool? status;
  int? responseCode;
  String? message;
  List<ExercisesData>? data;

  WorkoutDetailsModel({
    this.status,
    this.responseCode,
    this.message,
    this.data,
  });

  WorkoutDetailsModel.fromJson(dynamic json) {
    status = json['Status'];
    responseCode = json['ResponseCode'];
    message = json['Message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(ExercisesData.fromJson(v));
      });
    }
  }

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

class ExercisesData {
  ExercisesData({
    this.id,
    this.name,
    this.videoUrl,
    this.section,
    this.sectionId,
    this.coachId,
    this.note,
    this.rules,
  });

  ExercisesData.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    videoUrl = json['video_url'];
    section = json['section'];
    sectionId = json['section_id'];
    coachId = json['coach_id'];
    note = json['note'];
    if (json['rules'] != null) {
      rules = [];
      json['rules'].forEach((v) {
        rules?.add(Rules.fromJson(v));
      });
    }
  }

  String? id;
  String? name;
  String? videoUrl;
  String? section;
  String? sectionId;
  String? coachId;
  String? note;
  List<Rules>? rules;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['video_url'] = videoUrl;
    map['section'] = section;
    map['section_id'] = sectionId;
    map['coach_id'] = coachId;
    map['note'] = note;
    if (rules != null) {
      map['rules'] = rules?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Rules {
  Rules({
    this.id,
    this.training,
    this.value,
  }): ruleTextController = TextEditingController(text: value);

  Rules.fromJson(dynamic json) {
    id = json['training_id'];
    training = json['training'];
    value = json['value'];
    ruleTextController = TextEditingController(text: value);
  }

  String? id;
  String? training;
  String? value;
  TextEditingController? ruleTextController;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['training_id'] = id;
    map['training'] = training;
    map['value'] = value;
    return map;
  }
}
