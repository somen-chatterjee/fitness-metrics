
class CompareImages {
  List<Date>? date;

  CompareImages({
    this.date,
  });

  factory CompareImages.fromJson(Map<String, dynamic> json) => CompareImages(
    date: json["date"] == null
        ? []
        : List<Date>.from(json["date"]!.map((x) => Date.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "date": date == null
        ? []
        : List<dynamic>.from(date!.map((x) => x.toJson())),
  };
}

class Date {
  String? type;
  String? image;

  Date({
    this.type,
    this.image,
  });

  factory Date.fromJson(Map<String, dynamic> json) => Date(
    type: json["type"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "image": image,
  };
}
