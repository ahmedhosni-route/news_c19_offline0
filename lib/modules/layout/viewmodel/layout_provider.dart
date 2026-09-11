import 'package:flutter/material.dart';
import 'package:news_c19_offline/modules/layout/api_manager/api_manager.dart';

import '../../../core/category/app_category.dart';
import '../api_manager/models/news_response.dart';
import '../api_manager/models/source_response.dart';

class LayoutProvider extends ChangeNotifier {
  AppCategory? selectedCategory;
  Sources? selectedSource;
  List<Sources> sources = [];
  List<Articles> articles = [];


  ProviderState sourceState = ProviderState.loading;
  ProviderState newsState = ProviderState.loading;

  void backToHome() {
    selectedCategory = null;
    notifyListeners();
  }

  void selectCategory(AppCategory category) {
    selectedCategory = category;
    notifyListeners();
  }

  void selectSource(int index) {
    selectedSource = sources[index];
    notifyListeners();
    getNews();
  }

  void getSources() async {
    sourceState = ProviderState.loading;
    sources.clear();
    notifyListeners();
    try {
      sources = await ApiManager.getSources(selectedCategory!.id);
      selectedSource = sources.first;
      sourceState = ProviderState.success;
      getNews();
    } catch (e) {
      print(e);
      sourceState = ProviderState.error;
    }
    notifyListeners();
  }

  void getNews() async {
    newsState = ProviderState.loading;
    articles.clear();
    notifyListeners();
    try {
      articles = await ApiManager.getNews(selectedSource!.id!);
      newsState = ProviderState.success;
      notifyListeners();
    } catch (e) {
      print(e);
      newsState = ProviderState.error;
    }
    notifyListeners();
  }
}


enum ProviderState {
  loading,
  success,
  error;
}