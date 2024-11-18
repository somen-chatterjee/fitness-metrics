class PlanWorkoutModel {
  bool? status;
  String? message;
  int? responseCode;
  Data? data;
  int? currentPage;
  int? lastPage;
  int? total;

  PlanWorkoutModel(
      {this.status,
        this.message,
        this.responseCode,
        this.data,
        this.currentPage,
        this.lastPage,
        this.total});

  PlanWorkoutModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    message = json['Message'];
    responseCode = json['ResponseCode'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    currentPage = json['current_page'];
    lastPage = json['last_page'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Status'] = status;
    data['Message'] = message;
    data['ResponseCode'] = responseCode;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['current_page'] = currentPage;
    data['last_page'] = lastPage;
    data['total'] = total;
    return data;
  }
}

class Data {
  String? note;
  List<WorkoutData>? workouts;

  Data({this.note, this.workouts});

  Data.fromJson(Map<String, dynamic> json) {
    note = json['note'];
    if (json['workouts'] != null) {
      workouts = <WorkoutData>[];
      json['workouts'].forEach((v) {
        workouts!.add(WorkoutData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['note'] = note;
    if (workouts != null) {
      data['workouts'] = workouts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WorkoutData {
  String? id;
  String? name;
  String? startDate;
  String? finishDate;
  String? icon;
  bool? exerciseStatus;

  WorkoutData(
      {this.id,
        this.name,
        this.startDate,
        this.finishDate,
        this.icon,
        this.exerciseStatus});

  WorkoutData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    startDate = json['start_date'];
    finishDate = json['finish_date'];
    icon = json['icon'];
    exerciseStatus = json['exercise_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['start_date'] = startDate;
    data['finish_date'] = finishDate;
    data['icon'] = icon;
    data['exercise_status'] = exerciseStatus;
    return data;
  }
}
