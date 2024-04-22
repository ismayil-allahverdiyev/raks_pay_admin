import 'dart:convert';

RatesModel transactionModelFromJson(String str) =>
    RatesModel.fromJson(json.decode(str));

String transactionModelToJson(RatesModel data) => json.encode(data.toJson());

class RatesModel {
  String type;
  double value;

  RatesModel({
    required this.type,
    required this.value,
  });

  factory RatesModel.fromJson(Map<String, dynamic> json) => RatesModel(
        type: json["type"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "value": value,
      };
}
