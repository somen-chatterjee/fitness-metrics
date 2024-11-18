class GroupEditViewModel {
  GroupEditViewModel({
    this.status,
    this.responseCode,
    this.message,
    this.data,
  });

  GroupEditViewModel.fromJson(dynamic json) {
    status = json['Status'];
    responseCode = json['ResponseCode'];
    message = json['Message'];
    data = json['data'] != null ? GroupData.fromJson(json['data']) : null;
  }

  bool? status;
  int? responseCode;
  String? message;
  GroupData? data;

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

class GroupData {
  GroupData({
    this.groupName,
    this.group,
    this.anotherAthlete,
  });

  GroupData.fromJson(dynamic json) {
    groupName = json['group_name'];
    if (json['group'] != null) {
      group = [];
      json['group'].forEach((v) {
        group?.add(Athlete.fromJson(v));
      });
    }
    if (json['anotherAthlete'] != null) {
      anotherAthlete = [];
      json['anotherAthlete'].forEach((v) {
        anotherAthlete?.add(Athlete.fromJson(v));
      });
    }
  }

  String? groupName;
  List<Athlete>? group;
  List<Athlete>? anotherAthlete;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['group_name'] = groupName;
    if (group != null) {
      map['group'] = group?.map((v) => v.toJson()).toList();
    }
    if (anotherAthlete != null) {
      map['anotherAthlete'] = anotherAthlete?.map((v) => v.toJson()).toList();
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
    this.isSelected = false, // Add isSelected with default value as false
  });

  Athlete.fromJson(dynamic json) {
    userId = json['user_id'];
    name = json['name'];
    email = json['email'];
    age = json['age'];
    dateOfBirth = json['date_of_birth'];
    mobile = json['mobile'];
    image = json['image'];
    isSelected = json['isSelected'] ?? false; // Default false if not provided
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
    map['isSelected'] = isSelected;
    return map;
  }
}

