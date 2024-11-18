class CoachPreferenceModel {
  CoachPreferenceModel({
    this.status,
    this.responseCode,
    this.message,
    this.data,
  });

  CoachPreferenceModel.fromJson(dynamic json) {
    status = json['Status'];
    responseCode = json['ResponseCode'];
    message = json['Message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  bool? status;
  int? responseCode;
  String? message;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Status'] = status;
    map['ResponseCode'] = responseCode;
    map['Message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }
}

class Data {
  Data({
    this.sections,
    this.trainings,
    this.trainingTimes,
  });

  Data.fromJson(dynamic json) {
    if (json['sections'] != null) {
      sections = [];
      json['sections'].forEach((v) {
        sections?.add(Sections.fromJson(v));
      });
    }
    if (json['trainings'] != null) {
      trainings = [];
      json['trainings'].forEach((v) {
        trainings?.add(Trainings.fromJson(v));
      });
    }
    if (json['training_times'] != null) {
      trainingTimes = [];
      json['training_times'].forEach((v) {
        trainingTimes?.add(TrainingTimes.fromJson(v));
      });
    }
  }

  List<Sections>? sections;
  List<Trainings>? trainings;
  List<TrainingTimes>? trainingTimes;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (sections != null) {
      map['sections'] = sections?.map((v) => v.toJson()).toList();
    }
    if (trainings != null) {
      map['trainings'] = trainings?.map((v) => v.toJson()).toList();
    }
    if (trainingTimes != null) {
      map['training_times'] = trainingTimes?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class TrainingTimes {
  TrainingTimes({
    this.id,
    this.time,
  });

  TrainingTimes.fromJson(dynamic json) {
    id = json['id'];
    time = json['time'];
  }

  dynamic id;
  dynamic time;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['time'] = time;
    return map;
  }
}

class Trainings {
  Trainings({
    this.id,
    this.name,
    this.status,
  });

  Trainings.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
  }

  dynamic id;
  dynamic name;
  dynamic status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['status'] = status;
    return map;
  }
}

class Sections {
  Sections({
    this.id,
    this.name,
  });

  Sections.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
  }

  dynamic id;
  dynamic name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    return map;
  }
}
