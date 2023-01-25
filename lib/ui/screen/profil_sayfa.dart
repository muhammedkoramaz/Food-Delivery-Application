import 'package:flutter/material.dart';
import 'package:food_delivery_app/ui/assets/colors.dart';

class ProfilSayfa extends StatefulWidget {
  const ProfilSayfa({super.key});

  @override
  State<ProfilSayfa> createState() => _ProfilSayfaState();
}

class _ProfilSayfaState extends State<ProfilSayfa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profil Sayfası")),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 200,
                  height: 200,
                  child: Image.network(
                      "https://cdn-icons-png.flaticon.com/512/4140/4140048.png"),
                ),
                makeInput(label: "Kullanıcı Adı", hint: "muhammed_koramaz"),
                makeInput(label: "Adı", hint: "Muhammed"),
                makeInput(label: "Soyadı", hint: "Koramaz"),
                makeInput(label: "Adres", hint: "Kayseri"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget makeInput({label, hint}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
              fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
        ),
        const SizedBox(
          height: 5,
        ),
        SizedBox(
          width: 325,
          child: TextField(
            decoration: InputDecoration(
              hintText: hint,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,
                ),
              ),
              border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)),
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        )
      ],
    );
  }
}
