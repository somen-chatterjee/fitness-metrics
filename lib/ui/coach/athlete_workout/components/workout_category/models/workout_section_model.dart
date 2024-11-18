class WorkoutSectionModel {
  bool? status;
  int? responseCode;
  String? message;
  List<PredefinedSectionData>? data;

  WorkoutSectionModel(
      {this.status, this.responseCode, this.message, this.data});

  WorkoutSectionModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    responseCode = json['ResponseCode'];
    message = json['Message'];
    if (json['data'] != null) {
      data = <PredefinedSectionData>[];
      json['data'].forEach((v) {
        data!.add(PredefinedSectionData.fromJson(v));
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

class PredefinedSectionData {
  Section? section;
  List<Exercise>? exercise;

  PredefinedSectionData({this.section, this.exercise});

  PredefinedSectionData.fromJson(Map<String, dynamic> json) {
    section =
        json['section'] != null ? Section.fromJson(json['section']) : null;
    if (json['exercise'] != null) {
      exercise = <Exercise>[];
      json['exercise'].forEach((v) {
        exercise!.add(Exercise.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (section != null) {
      data['section'] = section!.toJson();
    }
    if (exercise != null) {
      data['exercise'] = exercise!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Section {
  int? sectionId;
  String? name;

  Section({this.sectionId, this.name});

  Section.fromJson(Map<String, dynamic> json) {
    sectionId = json['section_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['section_id'] = sectionId;
    data['name'] = name;
    return data;
  }
}

class Exercise {
  int? id;
  String? exercise;
  List<Rules>? rules;

  Exercise({this.id, this.exercise, this.rules});

  Exercise.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    exercise = json['exercise'];
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
    data['exercise'] = exercise;
    if (rules != null) {
      data['rules'] = rules!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Rules {
  int? id;
  String? name;
  String? value;

  Rules({this.id, this.name, this.value});

  Rules.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['value'] = value;
    return data;
  }
}
