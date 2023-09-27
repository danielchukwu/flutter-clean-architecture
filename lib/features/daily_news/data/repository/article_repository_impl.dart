import 'dart:io';

import 'package:flutter_clean_architecture/core/constants/constants.dart';
import 'package:flutter_clean_architecture/features/daily_news/data/data_sources/local/app_database.dart';
import 'package:flutter_clean_architecture/features/daily_news/data/data_sources/remote/news_api_service.dart';
import 'package:flutter_clean_architecture/features/daily_news/data/models/article.dart';
import 'package:flutter_clean_architecture/core/resources/data_state.dart';
import 'package:flutter_clean_architecture/features/daily_news/domain/entities/article.dart';
import 'package:flutter_clean_architecture/features/daily_news/domain/repositories/article_repository.dart';
import 'package:dio/dio.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final NewsApiService _apiService;
  final AppDatabase _appDatabase;

  const ArticleRepositoryImpl(this._apiService, this._appDatabase);

  @override
  Future<DataState<List<ArticleModel>>> getNewsArticles() async {
    print(newsAPIKey);
    print(categoryQuery);
    print(countryQuery);
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

  // Database
  @override
  Future<List<ArticleModel>> getSavedArticles() {
    print('Data - getSavedArticles');
    return _appDatabase.articleDao.getArticles();
  }
  
  @override
  Future<void> removeArticle(ArticleEntity article) {
    print('Data - removeArticle');
    return _appDatabase.articleDao.insertArticle(ArticleModel.fromEntity(article));
  }
  
  @override
  Future<void> saveArticle(ArticleEntity article) {
    print('Data - saveArticle');
    print(article);
    return _appDatabase.articleDao.deleteArticle(ArticleModel.fromEntity(article));
  }

}
