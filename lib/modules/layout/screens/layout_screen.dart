import 'package:flutter/material.dart';
import 'package:news_c19_offline/core/category/app_category.dart';
import 'package:news_c19_offline/core/theme/app_colors.dart';
import 'package:news_c19_offline/modules/layout/screens/articale_screen.dart';
import 'package:news_c19_offline/modules/layout/screens/home_screen.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  AppCategory? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        foregroundColor: AppColors.white,
        backgroundColor: AppColors.black,
        centerTitle: true,
        actions: [Icon(Icons.search)],
        title: Text(selectedCategory?.title ?? "Home"),
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
                selectedCategory = null;
                setState(() {});
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
      body: selectedCategory == null
          ? HomeScreen(
              onTap: (category) {
                selectedCategory = category;
                setState(() {});
              },
            )
          : ArticleScreen(
        category: selectedCategory!,
      ),
    );
  }
}
