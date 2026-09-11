import 'package:dio/dio.dart';
import 'package:news_c19_offline/core/service/network_service.dart';
import 'package:news_c19_offline/modules/layout/api_manager/models/news_response.dart';
import 'package:news_c19_offline/modules/layout/api_manager/models/source_response.dart';

class ApiManager {
  static Future<List<Articles>> getNews(String sourceId) async {
    try {
      var response = await NetworkService.dio.get(
        "everything",
        queryParameters: {"sources": sourceId},
      );
      if (response.statusCode == 200) {
        return NewsResponse.fromJson(response.data).articles ?? [];
      } else {
        throw response.data["message"];
      }
    } on DioException catch (e) {
      throw e.response?.data["message"];
    } catch (e) {
      rethrow;
    }
  }


  static Future<List<Sources>> getSources(String categoryId) async {
    try {
      
      var response = await NetworkService.dio.get(
        "top-headlines/sources",
        queryParameters: {"category": categoryId},
      );
      if (response.statusCode == 200) {
        return SourceResponse.fromJson(response.data).sources ?? [];
      } else {
        throw response.data["message"];
      }
    } on DioException catch (e) {
      throw e.response?.data["message"];
    } catch (e) {
      rethrow;
    }
  }
}
