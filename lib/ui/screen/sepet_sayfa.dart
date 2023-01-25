import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/ui/assets/colors.dart';
import 'package:food_delivery_app/ui/screen/animasyonlar.dart';
import 'package:lottie/lottie.dart';

import '../../data/entity/sepet.dart';
import '../cubit/sepet_sayfa_cubit.dart';

class SepetSayfa extends StatefulWidget {
  const SepetSayfa({super.key});

  @override
  State<SepetSayfa> createState() => _SepetSayfaState();
}

class _SepetSayfaState extends State<SepetSayfa> {
  double toplamTutar = 0;
  String animasyonUrl =
      "https://lottie.host/8b8ed572-7ea7-4b07-956d-a1545e2e14f9/5faUA0OO7W.json";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<SepetSayfaCubit>().sepetYukle("muhammed_koramaz");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sepet"),
      ),
      body: BlocBuilder<SepetSayfaCubit, List<Sepet>>(
        builder: (context, sepetListesi) {
          toplamTutar = 0;
          sepetListesi.forEach((element) {
            toplamTutar += int.parse(element.yemek_fiyat) *
                int.parse(element.yemek_siparis_adet);
          });
          if (sepetListesi.isNotEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 410,
                  child: SingleChildScrollView(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: sepetListesi.length,
                      itemBuilder: (context, index) {
                        var sepet = sepetListesi[index];
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: SizedBox(
                            width: 380,
                            height: 80,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16)),
                              child: Row(
                                children: [
                                  YemekResim(sepet: sepet),
                                  Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(sepet.yemek_adi),
                                        Text(
                                          "₺${sepet.yemek_fiyat}",
                                          style: TextStyle(
                                              color: anaRenk,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 15),
                                    child: SizedBox(
                                      width: 35,
                                      height: 35,
                                      child: CircleAvatar(
                                        child: Text(sepet.yemek_siparis_adet,
                                            style: TextStyle(
                                                color: anaRenk,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16)),
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              "${sepet.yemek_adi} sepetten silinsin mi?"),
                                          action: SnackBarAction(
                                              label: "Evet",
                                              onPressed: () {
                                                context
                                                    .read<SepetSayfaCubit>()
                                                    .sepettenSil(
                                                        int.parse(sepet
                                                            .sepet_yemek_id),
                                                        sepet.kullanici_adi);
                                              }),
                                        ),
                                      );
                                    },
                                    icon: const Icon(Icons.delete_outlined),
                                    color: anaRenk,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: SizedBox(
                    height: 185,
                    width: 370,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              gradient_start,
                              anaRenk,
                            ],
                          )),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            cardItem("Sipariş Toplamı", toplamTutar),
                            cardItem("Getirme Ücreti", 10),
                            cardItem("Poşet Ücreti", 0.25),
                            const Divider(
                              height: 25,
                              color: Colors.white,
                            ),
                            cardItem("Toplam Tutar", toplamTutar + 0.25 + 10),
                            Center(
                              child: SizedBox(
                                width: 300,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: const StadiumBorder(),
                                      backgroundColor: Colors.white,
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                Animasyonlar(url: animasyonUrl),
                                          ));
                                      context
                                          .read<SepetSayfaCubit>()
                                          .tumSepetiSil("muhammed_koramaz");
                                    },
                                    child: Text(
                                      "Siparişi Onayla",
                                      style: TextStyle(color: anaRenk),
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.network(
                      "https://lottie.host/cb7cd883-3dc1-4e9c-87c3-01661e97788d/v69g5YIdQI.json",
                      repeat: true,
                      animate: true),
                  Text(
                    "SEPET BOŞ",
                    style: TextStyle(
                      fontSize: 22,
                      color: anaRenk,
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Padding cardItem(String alan, double tutar) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$alan",
            style: const TextStyle(color: Colors.white),
          ),
          Text(
            "₺$tutar",
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class YemekResim extends StatelessWidget {
  const YemekResim({Key? key, required this.sepet}) : super(key: key);

  final Sepet sepet;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: SizedBox(
        height: 64,
        width: 64,
        child: Card(
          color: Color.fromARGB(177, 255, 0, 0),
          child: Image.network(
            "http://kasimadalan.pe.hu/yemekler/resimler/${sepet.yemek_resim_adi}",
            fit: BoxFit.fill,
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) {
                return child;
              }
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
