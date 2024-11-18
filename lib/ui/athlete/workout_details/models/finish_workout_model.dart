class FinishWorkoutModel {
  bool? status;
  int? responseCode;
  String? message;
  FinishData? data;

  FinishWorkoutModel({this.status, this.responseCode, this.message, this.data});

  FinishWorkoutModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    responseCode = json['ResponseCode'];
    message = json['Message'];
    data = json['data'] != null ? FinishData.fromJson(json['data']) : null;
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

class FinishData {
  String? id;
  String? workout;
  String? section;
  String? athlete;
  String? date;
  int? status;
  String? totalLoad;
  String? workoutTime;
  String? finishedWorkout;
  String? monthlyGoal;

  FinishData(
      {this.id,
      this.workout,
      this.section,
      this.athlete,
      this.date,
      this.status,
      this.totalLoad,
      this.workoutTime,
      this.finishedWorkout,
      this.monthlyGoal});

  FinishData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    workout = json['workout'];
    section = json['section'];
    athlete = json['athlete'];
    date = json['date'];
    status = json['status'];
    totalLoad = json['total_load'];
    workoutTime = json['workoutTime'];
    finishedWorkout = json['finished_workout'];
    monthlyGoal = json['monthly_goal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['workout'] = workout;
    data['section'] = section;
    data['athlete'] = athlete;
    data['date'] = date;
    data['status'] = status;
    data['total_load'] = totalLoad;
    data['workoutTime'] = workoutTime;
    data['finished_workout'] = finishedWorkout;
    data['monthly_goal'] = monthlyGoal;
    return data;
  }
}
