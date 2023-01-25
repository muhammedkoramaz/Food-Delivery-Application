import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:food_delivery_app/data/entity/yemekler.dart';
import 'package:food_delivery_app/ui/assets/colors.dart';
import 'package:food_delivery_app/ui/cubit/yemek_detay_cubit.dart';
import 'package:food_delivery_app/ui/screen/animasyonlar.dart';

class YemekDetay extends StatefulWidget {
  Yemekler yemek;
  YemekDetay({required this.yemek});

  @override
  State<YemekDetay> createState() => _YemekDetayState();
}

class _YemekDetayState extends State<YemekDetay> {
  var tfYemekAd = TextEditingController();
  int adet = 1;
  int tutar = 0;
  String animasyonUrl =
      "https://lottie.host/328fa05a-0478-483b-b622-9d13fdb32160/ZcGBqnbsm3.json";
  String kullanici_adi = "muhammed_koramaz";

  @override
  void initState() {
    super.initState();
    var yemek = widget.yemek;
    tfYemekAd.text = yemek.yemek_adi;
    tutar = int.parse(widget.yemek.yemek_fiyat);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Yemek Detayı"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Image.network(
                  'http://kasimadalan.pe.hu/yemekler/resimler/${widget.yemek.yemek_resim_adi}'),
              SizedBox(
                width: double.infinity,
                height: 129,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(17),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.yemek.yemek_adi,
                          style: const TextStyle(fontSize: 25),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 11),
                          child: Text("₺${widget.yemek.yemek_fiyat},00",
                              style: TextStyle(fontSize: 20, color: anaRenk)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (adet > 1) {
                            adet--;
                            tutar = adet * int.parse(widget.yemek.yemek_fiyat);
                          } else {
                            adet = 1;
                            tutar = int.parse(widget.yemek.yemek_fiyat);
                          }
                        });
                      },
                      child: const Text("-")),
                  SizedBox(
                    height: 45,
                    width: 40,
                    child: Card(
                      child: Center(child: Text("$adet")),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          adet = adet + 1;
                          tutar = adet * int.parse(widget.yemek.yemek_fiyat);
                        });
                      },
                      child: const Text("+")),
                ],
              ),
              SizedBox(
                height: 80,
                child: Card(
                  child: SizedBox(
                    height: 59,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 290,
                            height: 40,
                            child: ElevatedButton(
                              onPressed: () {
                                context
                                    .read<YemekDetayCubit>()
                                    .sepeteEkle(
                                        widget.yemek.yemek_adi,
                                        widget.yemek.yemek_resim_adi,
                                        int.parse(widget.yemek.yemek_fiyat),
                                        adet,
                                        kullanici_adi)
                                    .then((value) => {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    Animasyonlar(
                                                        url: animasyonUrl),
                                              ))
                                        });
                              },
                              child: const Text(
                                "Sepete Ekle",
                                style: TextStyle(fontSize: 17),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                            width: 78,
                            child: Card(
                              child: Center(
                                  child: Text(
                                "₺$tutar,00",
                                style: TextStyle(color: anaRenk, fontSize: 16),
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
          ),
        ],
      ),
    );
  }
}
