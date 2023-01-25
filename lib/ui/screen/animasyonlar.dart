import 'package:flutter/material.dart';
import 'package:food_delivery_app/ui/screen/giris_sayfa.dart';
import 'package:lottie/lottie.dart';

class Animasyonlar extends StatefulWidget {
  String url;
  Animasyonlar({super.key, required this.url});

  @override
  State<Animasyonlar> createState() => _AnimasyonlarState();
}

class _AnimasyonlarState extends State<Animasyonlar>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Center(
        child: Lottie.network(widget.url, controller: _controller,
            onLoaded: (composition) {
          _controller
            ..duration = composition.duration
            ..forward().whenComplete(() => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const GirisSayfa())));
        }),
      ),
    );
  }
}
