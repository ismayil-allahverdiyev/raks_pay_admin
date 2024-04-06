import 'dart:convert';

TransactionModel transactionModelFromJson(String str) =>
    TransactionModel.fromJson(json.decode(str));

String transactionModelToJson(TransactionModel data) =>
    json.encode(data.toJson());

class TransactionModel {
  int date;
  String number;
  double totalAmount;
  String fromCountry;
  String phoneCode;
  String currency;
  int requestedAmount;
  String id;
  String email;
  String toCountry;

  TransactionModel({
    required this.date,
    required this.number,
    required this.totalAmount,
    required this.fromCountry,
    required this.phoneCode,
    required this.currency,
    required this.requestedAmount,
    required this.id,
    required this.email,
    required this.toCountry,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      TransactionModel(
        date: json["date"],
        number: json["number"],
        totalAmount: json["totalAmount"]?.toDouble(),
        fromCountry: json["fromCountry"],
        phoneCode: json["phoneCode"],
        currency: json["currency"],
        requestedAmount: json["requestedAmount"],
        id: json["id"],
        email: json["email"],
        toCountry: json["toCountry"],
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "number": number,
        "totalAmount": totalAmount,
        "fromCountry": fromCountry,
        "phoneCode": phoneCode,
        "currency": currency,
        "requestedAmount": requestedAmount,
        "id": id,
        "email": email,
        "toCountry": toCountry,
      };
}
