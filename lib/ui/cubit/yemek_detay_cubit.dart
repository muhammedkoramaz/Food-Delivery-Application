import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/data/entity/sepet.dart';
import 'package:food_delivery_app/data/entity/yemekler.dart';
import 'package:food_delivery_app/data/repo/yemekler_repository.dart';

class YemekDetayCubit extends Cubit<void> {
  YemekDetayCubit() : super(0); //void
  var yrepo = YemeklerRepository();

  Future<void> sepeteEkle(String yemek_adi, String yemek_resim_adi,
      int yemek_fiyat, int yemek_siparis_adet, String kullanici_adi) async {
    await yrepo.sepeteEkle(yemek_adi, yemek_resim_adi, yemek_fiyat,
        yemek_siparis_adet, kullanici_adi);
  }
}
