import 'package:flutter/material.dart';

import '../../../core/category/app_category.dart';

class LayoutProvider extends ChangeNotifier {
  AppCategory? selectedCategory;

  void backToHome() {
    selectedCategory = null;
    notifyListeners();
  }

  void selectCategory(AppCategory category) {
    selectedCategory = category;
    notifyListeners();
  }
}
