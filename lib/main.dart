import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:appnghenhac/ui/home/home.dart';
import 'package:appnghenhac/ui/loginsignup.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const Posali());
}

class Posali extends StatelessWidget {
  const Posali({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SpotifyIntroScreen(),
    );
  }
}