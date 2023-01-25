import 'package:food_delivery_app/data/entity/yemekler.dart';

class YemeklerResponse {
  List<Yemekler> yemekler;
  int success;
  YemeklerResponse({
    required this.yemekler,
    required this.success,
  });
  factory YemeklerResponse.fromJson(Map<String, dynamic> json) {
    var jsonArray = json["yemekler"] as List;
    var yemekler = jsonArray.map((e) => Yemekler.fromJson(e)).toList();
    return YemeklerResponse(
        yemekler: yemekler, success: json["success"] as int);
  }
}
