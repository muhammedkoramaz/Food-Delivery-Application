import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:food_delivery_app/data/entity/yemekler.dart';
import 'package:food_delivery_app/data/repo/yemekler_repository.dart';

class AnasayfaCubit extends Cubit<List<Yemekler>> {
  AnasayfaCubit() : super(<Yemekler>[]);
  var yrepo = YemeklerRepository();
  Future<void> yemekleriYukle() async {
    var liste = await yrepo.yemekleriYukle();
    emit(liste);
  }
}
