import 'package:flutter/material.dart';
import 'package:news_c19_offline/core/theme/app_colors.dart';
import 'package:news_c19_offline/modules/layout/viewmodel/layout_provider.dart';
import 'package:provider/provider.dart';

import 'articale_screen.dart';
import 'home_screen.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => LayoutProvider(),
      builder: (context, child) {
        var provider = Provider.of<LayoutProvider>(context);
        return Scaffold(
          backgroundColor: AppColors.black,
          appBar: AppBar(
            foregroundColor: AppColors.white,
            backgroundColor: AppColors.black,
            centerTitle: true,
            actions: [Icon(Icons.search)],
            title: Text(provider.selectedCategory?.title ?? "Home"),
          ),
          drawer: Drawer(
            backgroundColor: AppColors.black,
            child: Column(
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(color: AppColors.white),
                  child: Center(
                    child: Text(
                      "News App",
                      style: TextStyle(fontSize: 30, color: AppColors.black),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    provider.backToHome();
                    Navigator.pop(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(Icons.home, size: 40, color: AppColors.white),
                      Text(
                        "Back To home",
                        style: TextStyle(
                          fontSize: 30,
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          body: provider.selectedCategory == null
              ? HomeScreen(
            onTap: provider.selectCategory,
          )
              : ArticleScreen(
            category: provider.selectedCategory!,
          ),
        );
      },
    );
  }
}
