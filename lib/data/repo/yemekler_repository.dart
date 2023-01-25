import 'package:dio/dio.dart';
import 'package:food_delivery_app/data/entity/sepet.dart';
import 'package:food_delivery_app/data/entity/sepet_response.dart';

import 'dart:convert';

import 'package:food_delivery_app/data/entity/yemekler.dart';
import 'package:food_delivery_app/data/entity/yemekler_response.dart';

class YemeklerRepository {
  List<Yemekler> parseYemekler(String cevap) {
    return YemeklerResponse.fromJson(json.decode(cevap)).yemekler;
  }

  List<Sepet> parseSepet(String cevap) {
    return SepetResponse.fromJson(json.decode(cevap)).sepet;
  }

  Future<List<Yemekler>> yemekleriYukle() async {
    var url = "http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php";
    var cevap = await Dio().get(url);
    return parseYemekler(cevap.data.toString());
  }

  Future<List<Sepet>> sepetYukle(String kullanici_adi) async {
    var url = "http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php";
    var veri = {"kullanici_adi": kullanici_adi};
    var cevap = await Dio().post(url, data: FormData.fromMap(veri));
    if (cevap.data.toString().contains("sepet_yemekler")) {
      return parseSepet(cevap.data.toString());
    } else {
      return [];
    }
  }

  Future<void> sepeteEkle(String yemek_adi, String yemek_resim_adi,
      int yemek_fiyat, int yemek_siparis_adet, String kullanici_adi) async {
    List<Sepet> sepet = await sepetYukle(kullanici_adi);
    int adet = 0;

    var url = "http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php";
    var veri = {
      "yemek_adi": yemek_adi,
      "yemek_resim_adi": yemek_resim_adi,
      "yemek_fiyat": yemek_fiyat,
      "yemek_siparis_adet": yemek_siparis_adet,
      "kullanici_adi": kullanici_adi
    };
    sepet.forEach((element) {
      if (element.yemek_adi == yemek_adi) {
        veri.update(
            "yemek_siparis_adet",
            (value) =>
                yemek_siparis_adet + int.parse(element.yemek_siparis_adet));
        sepettenSil(int.parse(element.sepet_yemek_id), kullanici_adi);
      }
    });
    var cevap = await Dio().post(url, data: FormData.fromMap(veri));
  }

  Future<void> sepettenSil(int sepet_yemek_id, String kullanici_adi) async {
    var url = "http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php";
    var veri = {
      "sepet_yemek_id": sepet_yemek_id,
      "kullanici_adi": kullanici_adi
    };
    var cevap = await Dio().post(url, data: FormData.fromMap(veri));
  }

  Future<void> tumSepetiSil(String kullanici_adi) async {
    List<Sepet> sepet = await sepetYukle(kullanici_adi);
    sepet.forEach((element) {
      sepettenSil(int.parse(element.sepet_yemek_id), kullanici_adi);
    });
  }
}
