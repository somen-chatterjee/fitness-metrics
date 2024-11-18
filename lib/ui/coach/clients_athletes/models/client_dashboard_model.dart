class ClientDashboardModel {
  ClientDashboardModel({
    this.status,
    this.responseCode,
    this.message,
    this.data,
  });

  ClientDashboardModel.fromJson(dynamic json) {
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
    this.group,
    this.athlete,
  });

  Data.fromJson(dynamic json) {
    if (json['group'] != null) {
      group = [];
      json['group'].forEach((v) {
        group?.add(Group.fromJson(v));
      });
    }
    if (json['athlete'] != null) {
      athlete = [];
      json['athlete'].forEach((v) {
        athlete?.add(Athlete.fromJson(v));
      });
    }
  }

  List<Group>? group;
  List<Athlete>? athlete;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (group != null) {
      map['group'] = group?.map((v) => v.toJson()).toList();
    }
    if (athlete != null) {
      map['athlete'] = athlete?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Athlete {
  Athlete({
    this.userId,
    this.name,
    this.email,
    this.age,
    this.dateOfBirth,
    this.mobile,
    this.image,
    this.isSelected,
  });

  Athlete.fromJson(dynamic json) {
    userId = json['user_id'];
    name = json['name'];
    email = json['email'];
    age = json['age'];
    dateOfBirth = json['date_of_birth'];
    mobile = json['mobile'];
    image = json['image'];
    isSelected = false;
  }

  int? userId;
  String? name;
  String? email;
  int? age;
  String? dateOfBirth;
  String? mobile;
  String? image;
  bool? isSelected;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = userId;
    map['name'] = name;
    map['email'] = email;
    map['age'] = age;
    map['date_of_birth'] = dateOfBirth;
    map['mobile'] = mobile;
    map['image'] = image;
    return map;
  }
}

class Group {
  Group({
    this.id,
    this.coach,
    this.athlete,
    this.name,
  });

  Group.fromJson(dynamic json) {
    id = json['id'];
    coach = json['coach'];
    athlete = json['athlete'];
    name = json['name'];
  }

  String? id;
  String? coach;
  String? athlete;
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['coach'] = coach;
    map['athlete'] = athlete;
    map['name'] = name;
    return map;
  }
}
