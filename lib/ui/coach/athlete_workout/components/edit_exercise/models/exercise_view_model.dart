import 'package:flutter/material.dart';

class ExerciseViewModel {
  bool? status;
  int? responseCode;
  String? message;
  Data? data;

  ExerciseViewModel({this.status, this.responseCode, this.message, this.data});

  ExerciseViewModel.fromJson(Map<String, dynamic> json) {
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
  String? id;
  String? name;
  int? load;
  String? videoUrl;
  String? section;
  String? note;
  List<Rules>? rules;

  Data(
      {this.id, this.name, this.load, this.videoUrl, this.section, this.note, this.rules});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    load = json['load'];
    videoUrl = json['video_url'];
    section = json['section'];
    note = json['note'];
    if (json['rules'] != null) {
      rules = <Rules>[];
      json['rules'].forEach((v) {
        rules!.add(Rules.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['load'] = load;
    data['video_url'] = videoUrl;
    data['section'] = section;
    data['note'] = note;
    if (rules != null) {
      data['rules'] = rules!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Rules {
  dynamic trainingId;
  dynamic training;
  dynamic value;
  TextEditingController? valueCtrl;

  Rules({
    this.trainingId,
    this.training,
    this.value,
  }) : valueCtrl = TextEditingController(text: value);

  Rules.fromJson(Map<String, dynamic> json) {
    trainingId = json['training_id'];
    training = json['training'];
    value = json['value'];
    valueCtrl = TextEditingController(text: value);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['training_id'] = trainingId;
    data['training'] = training;
    data['value'] = value;
    return data;
  }
}
