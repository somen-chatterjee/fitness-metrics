import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TrainingPreferencesModel {
  bool? status;
  int? responseCode;
  String? message;
  List<PreferenceData>? data;

  TrainingPreferencesModel(
      {this.status, this.responseCode, this.message, this.data});

  TrainingPreferencesModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    responseCode = json['ResponseCode'];
    message = json['Message'];
    if (json['data'] != null) {
      data = <PreferenceData>[];
      json['data'].forEach((v) {
        data!.add(PreferenceData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Status'] = status;
    data['ResponseCode'] = responseCode;
    data['Message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PreferenceData {
  int? id;
  String? question;
  String? answer;
  TextEditingController? answerController;

  PreferenceData({
    this.id,
    this.question,
    this.answer,
  }):answerController = TextEditingController(text: answer);

  PreferenceData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    answer = json['answer'];
    answerController = TextEditingController(text: answer);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['question'] = question;
    data['answer'] = answer;
    return data;
  }
}
