import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/data/entity/yemekler.dart';
import 'package:food_delivery_app/ui/assets/colors.dart';
import 'package:food_delivery_app/ui/cubit/anasayfa_cubit.dart';
import 'package:food_delivery_app/ui/screen/yemek_detay.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({super.key});

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  @override
  void initState() {
    super.initState();
    context.read<AnasayfaCubit>().yemekleriYukle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Yemek Menüsü"),
      ),
      body: BlocBuilder<AnasayfaCubit, List<Yemekler>>(
        builder: (context, yemeklerListesi) {
          if (yemeklerListesi.isNotEmpty) {
            return ListView.builder(
              itemCount: yemeklerListesi.length,
              itemBuilder: (context, index) {
                var yemek = yemeklerListesi[index];
                return GestureDetector(
                    onTap: () {
                      Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => YemekDetay(yemek: yemek),
                              ))
                          .then((value) =>
                              {context.read<AnasayfaCubit>().yemekleriYukle()});
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: SizedBox(
                        width: 380,
                        height: 80,
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          child: Row(
                            children: [
                              YemekResim(yemek: yemek),
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Text(yemek.yemek_adi),
                              ),
                              const Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 15),
                                child: Text("₺${yemek.yemek_fiyat}",
                                    style: TextStyle(
                                        color: anaRenk,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 20)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ));
              },
            );
          } else {
            return const Center();
          }
        },
      ),
    );
  }
}

class YemekResim extends StatelessWidget {
  const YemekResim({Key? key, required this.yemek}) : super(key: key);

  final Yemekler yemek;

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
            "http://kasimadalan.pe.hu/yemekler/resimler/${yemek.yemek_resim_adi}",
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
