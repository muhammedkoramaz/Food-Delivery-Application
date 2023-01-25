import 'package:food_delivery_app/data/entity/sepet.dart';

class SepetResponse {
  List<Sepet> sepet;
  int success;

  SepetResponse({
    required this.sepet,
    required this.success,
  });

  factory SepetResponse.fromJson(Map<String, dynamic> json) {
    var jsonArray = json["sepet_yemekler"] as List;
    var sepet = jsonArray.map((e) => Sepet.fromJson(e)).toList();
    return SepetResponse(sepet: sepet, success: json["success"] as int);
  }
}
