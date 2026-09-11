import 'package:flutter/material.dart';
import 'package:news_c19_offline/core/theme/app_colors.dart';
import 'package:news_c19_offline/modules/layout/screens/layout_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    Future.delayed(Duration(seconds: 4),() {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return LayoutScreen();
      },));
    },);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Column(
        children: [
          Expanded(child: Center(child: Image.asset("assets/logo/app_logo.png"),)),
          Image.asset("assets/logo/route_logo.png",width: 200,)
        ],
      ),
    );
  }
}
