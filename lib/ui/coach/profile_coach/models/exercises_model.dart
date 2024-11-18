class ExercisesModel {
  ExercisesModel({
    this.status,
    this.responseCode,
    this.message,
    this.data,
  });

  ExercisesModel.fromJson(dynamic json) {
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

class ExerciseData {
  ExerciseData({
    this.id,
    this.name,
    this.videoUrl,
    this.isSelected,
  });

  ExerciseData.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    videoUrl = json['video_url'];
    if (json['rules'] != null) {
      rules = <Rules>[];
      json['rules'].forEach((v) {
        rules!.add(Rules.fromJson(v));
      });
    }
    isSelected = false;
  }

  int? id;
  String? name;
  String? videoUrl;
  List<Rules>? rules;
  bool? isSelected;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['video_url'] = videoUrl;
    if (rules != null) {
      map['rules'] = rules!.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Rules {
  dynamic trainingId;
  dynamic training;
  dynamic value;

  Rules({
    this.trainingId,
    this.training,
    this.value,
  });

  Rules.fromJson(Map<String, dynamic> json) {
    trainingId = json['training_id'];
    training = json['training'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['training_id'] = trainingId;
    data['training'] = training;
    data['value'] = value;
    return data;
  }
}
