class AthleteProfileViewModel {
  AthleteProfileViewModel({
    this.status,
    this.responseCode,
    this.message,
    this.data,
  });

  AthleteProfileViewModel.fromJson(dynamic json) {
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
    this.user,
    this.details,
  });

  Data.fromJson(dynamic json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    if (json['details'] != null) {
      details = [];
      json['details'].forEach((v) {
        details?.add(Details.fromJson(v));
      });
    }
  }

  User? user;
  List<Details>? details;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (user != null) {
      map['user'] = user?.toJson();
    }
    if (details != null) {
      map['details'] = details?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Details {
  Details({
    this.date,
    this.weight,
    this.weightUnit,
    this.height,
    this.heightUnit,
    this.frontImage,
    this.sideImage,
    this.backImage,
  });

  Details.fromJson(dynamic json) {
    date = json['date'];
    weight = json['weight'];
    weightUnit = json['weightUnit'];
    height = json['height'];
    heightUnit = json['heightUnit'];
    frontImage = json['front_image'];
    sideImage = json['side_image'];
    backImage = json['back_image'];
  }

  String? date;
  String? weight;
  String? weightUnit;
  String? height;
  String? heightUnit;
  String? frontImage;
  String? sideImage;
  String? backImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['date'] = date;
    map['weight'] = weight;
    map['weightUnit'] = weightUnit;
    map['height'] = height;
    map['heightUnit'] = heightUnit;
    map['front_image'] = frontImage;
    map['side_image'] = sideImage;
    map['back_image'] = backImage;
    return map;
  }
}

class User {
  User({
    this.userId,
    this.name,
    this.email,
    this.status,
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
    this.finishedWorkout,
    this.monthlyGoals,
    this.time,
  });

  User.fromJson(dynamic json) {
    userId = json['user_id'];
    name = json['name'];
    email = json['email'];
    status = json['status'];
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
    finishedWorkout = json['finished_workout'];
    monthlyGoals = json['monthly_goal'];
    time = json['time'];
  }

  String? userId;
  String? name;
  String? email;
  int? status;
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
  String? finishedWorkout;
  String? monthlyGoals;
  String? time;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = userId;
    map['name'] = name;
    map['email'] = email;
    map['status'] = status;
    map['age'] = age;
    map['date_of_birth'] = dateOfBirth;
    map['mobile'] = mobile;
    map['gender'] = gender;
    map['image'] = image;
    map['weight'] = weight;
    map['weightUnit'] = weightUnit;
    map['height'] = height;
    map['heightUnit'] = heightUnit;
    map['bmi'] = bmi;
    map['finished_workout'] = finishedWorkout;
    map['monthly_goal'] = monthlyGoals;
    map['time'] = time;
    return map;
  }
}
