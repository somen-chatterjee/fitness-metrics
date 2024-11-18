class CheckRoleId {
  int? coach;
  int? athlete;

  CheckRoleId({
    this.coach = 3,
    this.athlete = 4,
  });

  CheckRoleId.fromJson(Map<String, dynamic> json) {
    coach = json['Coach'];
    athlete = json['Athlete'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Coach'] = coach;
    data['Athlete'] = athlete;
    return data;
  }
}
