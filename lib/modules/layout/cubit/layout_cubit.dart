import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/category/app_category.dart';
import '../api_manager/api_manager.dart';
import '../api_manager/models/source_response.dart';
import 'layout_state.dart';

class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit() : super(InitState());
  AppCategory? selectedCategory;
  Sources? selectedSource;
  List<Sources> sources = [];

  void backToHome() {
    selectedCategory = null;
    emit(BackHomeState());
  }

  void selectCategory(AppCategory category) {
    selectedCategory = category;
    emit(SelectCategoryState());
  }

  void selectSource(int index) {
    selectedSource = sources[index];
    getNews();
  }

  void getSources() async {
    sources.clear();
    emit(GetSourcesLoadingState());
    try {
      sources = await ApiManager.getSources(selectedCategory!.id);
      selectedSource = sources.first;
      emit(GetSourcesSuccessState());

      getNews();
    } catch (e) {
      print(e);
      emit(GetSourcesErrorState(e.toString()));
    }
  }

  void getNews() async {
    emit(GetNewsLoadingState());

    try {
      var articles = await ApiManager.getNews(selectedSource!.id!);
      emit(GetNewsSuccessState(articles));
    } catch (e) {
      print(e);
      emit(GetNewsErrorState(e.toString()));
    }
  }
}
