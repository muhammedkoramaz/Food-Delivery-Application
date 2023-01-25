import 'package:flutter/material.dart';
import 'package:food_delivery_app/ui/screen/profil_sayfa.dart';
import 'package:food_delivery_app/ui/screen/sepet_sayfa.dart';

import 'anasayfa.dart';

class GirisSayfa extends StatefulWidget {
  const GirisSayfa({super.key});

  @override
  State<GirisSayfa> createState() => _GirisSayfaState();
}

class _GirisSayfaState extends State<GirisSayfa> {
  int currentPage = 0;
  final screens = [const Anasayfa(), const SepetSayfa(), const ProfilSayfa()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentPage],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        currentIndex: currentPage,
        onTap: (index) {
          setState(() {
            currentPage = index;
          });
        },
        backgroundColor: Colors.white,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Anasayfa"),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_basket), label: "Sepet"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"),
        ],
      ),
    );
  }
}
