import 'dart:convert';

ReviewModel transactionModelFromJson(String str) =>
    ReviewModel.fromJson(json.decode(str));

String transactionModelToJson(ReviewModel data) => json.encode(data.toJson());

class ReviewModel {
  String id;
  DateTime date;
  String description;
  String image;
  String name;
  String main;
  String title;
  String from;

  ReviewModel({
    required this.id,
    required this.date,
    required this.description,
    required this.image,
    required this.main,
    required this.title,
    required this.name,
    required this.from,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) => ReviewModel(
        id: json["id"],
        date: DateTime.fromMillisecondsSinceEpoch(
            json["date"].millisecondsSinceEpoch * 1000),
        description: json["description"],
        image: json["image"],
        main: json["main"],
        title: json["title"],
        name: json["name"],
        from: json["from"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date": date,
        "description": description,
        "image": image,
        "main": main,
        "title": title,
        "name": name,
        "from": from,
      };
}
