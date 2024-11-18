class CoachProfileModel {
  CoachProfileModel({
    this.status,
    this.responseCode,
    this.message,
    this.data,
  });

  CoachProfileModel.fromJson(dynamic json) {
    status = json['Status'];
    responseCode = json['ResponseCode'];
    message = json['Message'];
    data = json['data'] != null ? ProfileData.fromJson(json['data']) : null;
  }

  bool? status;
  int? responseCode;
  String? message;
  ProfileData? data;

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

class ProfileData {
  ProfileData({
    this.userId,
    this.name,
    this.email,
    this.coachCode,
    this.age,
    this.dateOfBirth,
    this.mobile,
    this.whatsappNumber,
    this.profileUrl,
    this.websiteUrl,
    this.image,
    this.resume,
    this.isSubscribed,
  });

  ProfileData.fromJson(dynamic json) {
    userId = json['user_id'];
    name = json['name'];
    email = json['email'];
    coachCode = json['coach_code'];
    age = json['age'];
    dateOfBirth = json['date_of_birth'];
    mobile = json['mobile'];
    whatsappNumber = json['whatsapp_number'];
    profileUrl = json['profile_url'];
    websiteUrl = json['website_url'];
    image = json['image'];
    resume = json['resume'];
    isSubscribed = json['is_subscribed'];
  }

  String? userId;
  String? name;
  String? email;
  String? coachCode;
  int? age;
  String? dateOfBirth;
  String? mobile;
  String? whatsappNumber;
  String? profileUrl;
  String? websiteUrl;
  String? image;
  String? resume;
  bool? isSubscribed;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = userId;
    map['name'] = name;
    map['email'] = email;
    map['age'] = age;
    map['date_of_birth'] = dateOfBirth;
    map['mobile'] = mobile;
    map['whatsapp_number'] = whatsappNumber;
    map['profile_url'] = profileUrl;
    map['website_url'] = websiteUrl;
    map['image'] = image;
    map['resume'] = resume;
    map['is_subscribed'] = isSubscribed;
    return map;
  }
}
