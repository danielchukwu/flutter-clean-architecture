import 'dart:io';

import 'package:flutter_clean_architecture/core/constants/constants.dart';
import 'package:flutter_clean_architecture/features/daily_news/data/data_sources/remote/news_api_service.dart';
import 'package:flutter_clean_architecture/features/daily_news/data/models/article.dart';
import 'package:flutter_clean_architecture/core/resources/data_state.dart';
import 'package:flutter_clean_architecture/features/daily_news/domain/repositories/article_repository.dart';
import 'package:dio/dio.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final NewsApiService _apiService;

  const ArticleRepositoryImpl(this._apiService);

  @override
  Future<DataState<List<ArticleModel>>> getNewsArticles() async {
    try {
      final httpResponse = await _apiService.getNewsArticles(
        apiKey: newsAPIKey,
        category: categoryQuery,
        country: countryQuery,
      );

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(DioException(
            error: httpResponse.response.statusMessage,
            requestOptions: httpResponse.response.requestOptions,
            type: DioExceptionType.badResponse,
            response: httpResponse.response));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
