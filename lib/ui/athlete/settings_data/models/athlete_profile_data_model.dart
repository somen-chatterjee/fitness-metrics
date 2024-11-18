class AthleteProfileDataModel {
  bool? status;
  int? responseCode;
  String? message;
  Data? data;

  AthleteProfileDataModel(
      {this.status, this.responseCode, this.message, this.data});

  AthleteProfileDataModel.fromJson(Map<String, dynamic> json) {
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
  User? user;
  List<Details>? details;
  CoachDetails? coachDetails;

  Data({this.user, this.details, this.coachDetails});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    if (json['details'] != null) {
      details = <Details>[];
      json['details'].forEach((v) {
        details!.add(Details.fromJson(v));
      });
    }
    coachDetails = json['coachDetails'] != null
        ? CoachDetails.fromJson(json['coachDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (details != null) {
      data['details'] = details!.map((v) => v.toJson()).toList();
    }
    if (coachDetails != null) {
      data['coachDetails'] = coachDetails!.toJson();
    }
    return data;
  }
}

class User {
  String? userId;
  String? name;
  String? email;
  String? time;
  int? age;
  String? dateOfBirth;
  String? mobile;
  String? gender;
  String? image;
  String? weight;
  String? weightUnit;
  String? height;
  String? heightUnit;
  String? bmi;
  String? monthlyGoals;
  String? finishedWorkout;

  User(
      {this.userId,
      this.name,
      this.email,
      this.time,
      this.age,
      this.dateOfBirth,
      this.mobile,
      this.gender,
      this.image,
      this.weight,
      this.weightUnit,
      this.height,
      this.heightUnit,
      this.bmi,
      this.monthlyGoals,
      this.finishedWorkout,
      });

  User.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    name = json['name'];
    email = json['email'];
    time = json['time'];
    age = json['age'];
    dateOfBirth = json['date_of_birth'];
    mobile = json['mobile'];
    gender = json['gender'];
    image = json['image'];
    weight = json['weight'];
    weightUnit = json['weightUnit'];
    height = json['height'];
    heightUnit = json['heightUnit'];
    bmi = json['bmi'];
    monthlyGoals = json['monthly_goal'];
    finishedWorkout = json['finished_workout'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['name'] = name;
    data['email'] = email;
    data['time'] = time;
    data['age'] = age;
    data['date_of_birth'] = dateOfBirth;
    data['mobile'] = mobile;
    data['gender'] = gender;
    data['image'] = image;
    data['weight'] = weight;
    data['weightUnit'] = weightUnit;
    data['height'] = height;
    data['heightUnit'] = heightUnit;
    data['bmi'] = bmi;
    data['monthly_goal'] = monthlyGoals;
    data['finished_workout'] = finishedWorkout;
    return data;
  }
}

class Details {
  String? date;
  String? weight;
  String? weightUnit;
  String? height;
  String? heightUnit;
  String? frontImage;
  String? sideImage;
  String? backImage;

  Details(
      {this.date,
      this.weight,
      this.weightUnit,
      this.height,
      this.heightUnit,
      this.frontImage,
      this.sideImage,
      this.backImage});

  Details.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    weight = json['weight'];
    weightUnit = json['weightUnit'];
    height = json['height'];
    heightUnit = json['heightUnit'];
    frontImage = json['front_image'];
    sideImage = json['side_image'];
    backImage = json['back_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['weight'] = weight;
    data['weightUnit'] = weightUnit;
    data['height'] = height;
    data['heightUnit'] = heightUnit;
    data['front_image'] = frontImage;
    data['side_image'] = sideImage;
    data['back_image'] = backImage;
    return data;
  }
}

class CoachDetails {
  String? coachId;
  String? name;
  String? email;
  String? coachCode;
  int? age;
  String? dateOfBirth;
  String? mobile;
  String? profileUrl;
  String? websiteUrl;
  String? resume;
  String? whatsapp;
  String? image;

  CoachDetails(
      {this.coachId,
      this.name,
      this.email,
      this.coachCode,
      this.age,
      this.dateOfBirth,
      this.mobile,
      this.profileUrl,
      this.websiteUrl,
      this.resume,
      this.whatsapp,
      this.image});

  CoachDetails.fromJson(Map<String, dynamic> json) {
    coachId = json['coach_id'];
    name = json['name'];
    email = json['email'];
    coachCode = json['coach_code'];
    age = json['age'];
    dateOfBirth = json['date_of_birth'];
    mobile = json['mobile'];
    profileUrl = json['profile_url'];
    websiteUrl = json['website_url'];
    resume = json['resume'];
    whatsapp = json['whatsapp'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['coach_id'] = coachId;
    data['name'] = name;
    data['email'] = email;
    data['coach_code'] = coachCode;
    data['age'] = age;
    data['date_of_birth'] = dateOfBirth;
    data['mobile'] = mobile;
    data['profile_url'] = profileUrl;
    data['website_url'] = websiteUrl;
    data['resume'] = resume;
    data['whatsapp'] = whatsapp;
    data['image'] = image;
    return data;
  }
}
