import 'package:flutter/material.dart';
import 'package:news_c19_offline/modules/splash/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Ahmed(
      home: SplashScreen(),
    );
  }
}
