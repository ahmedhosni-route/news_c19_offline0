import 'package:news_c19_offline/modules/layout/api_manager/models/news_response.dart';

sealed class LayoutState {}

class InitState extends LayoutState {}

class BackHomeState extends LayoutState {}

class SelectCategoryState extends LayoutState {}

class GetSourcesSuccessState extends LayoutState {}

class GetSourcesErrorState extends LayoutState {
  String error;

  GetSourcesErrorState(this.error);
}

class GetSourcesLoadingState extends LayoutState {}

class GetNewsSuccessState extends LayoutState {
  List<Articles> articles = [];

  GetNewsSuccessState(this.articles);
}

class GetNewsErrorState extends LayoutState {
  String error;

  GetNewsErrorState(this.error);
}

class GetNewsLoadingState extends LayoutState {}
