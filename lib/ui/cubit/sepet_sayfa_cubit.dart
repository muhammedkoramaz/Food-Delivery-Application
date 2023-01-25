import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/data/entity/sepet.dart';

import '../../data/repo/yemekler_repository.dart';

class SepetSayfaCubit extends Cubit<List<Sepet>> {
  SepetSayfaCubit() : super(<Sepet>[]);

  var yrepo = YemeklerRepository();

  Future<void> sepetYukle(String kullanici_adi) async {
    var liste = await yrepo.sepetYukle(kullanici_adi);
    emit(liste);
  }

  Future<void> sepettenSil(int sepet_yemek_id, String kullanici_adi) async {
    await yrepo.sepettenSil(sepet_yemek_id, kullanici_adi);
    await sepetYukle(kullanici_adi);
  }

  Future<void> tumSepetiSil(String kullanici_adi) async {
    await yrepo.tumSepetiSil(kullanici_adi);
  }
}
