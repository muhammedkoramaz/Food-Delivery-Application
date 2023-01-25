import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/ui/cubit/anasayfa_cubit.dart';
import 'package:food_delivery_app/ui/cubit/sepet_sayfa_cubit.dart';
import 'package:food_delivery_app/ui/cubit/yemek_detay_cubit.dart';
import 'package:food_delivery_app/ui/screen/giris_sayfa.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AnasayfaCubit()),
        BlocProvider(create: (context) => SepetSayfaCubit()),
        BlocProvider(create: (context) => YemekDetayCubit()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            fontFamily: 'SansPro',
            primaryColor: Colors.white,
            scaffoldBackgroundColor: const Color(0xFFF7F8FE),
            primarySwatch: Colors.red),
        home: const GirisSayfa(),
      ),
    );
  }
}
