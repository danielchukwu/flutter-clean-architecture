import 'package:flutter_clean_architecture/core/resources/data_state.dart';
import 'package:flutter_clean_architecture/features/daily_news/domain/entities/article.dart';
import 'package:flutter_clean_architecture/features/daily_news/domain/repositories/article_repository.dart';
import 'package:flutter_clean_architecture/features/daily_news/domain/usecases/usecase.dart';

class GetArticlesUseCase implements UseCase<DataState<List<ArticleEntity>>, void> {
  final ArticleRepository _articleRepository;

  const GetArticlesUseCase(this._articleRepository);
  
  @override
  Future<DataState<List<ArticleEntity>>> call({void param}) async {
    // print('Start');
    DataState<List<ArticleEntity>> data = await _articleRepository.getNewsArticles();
    // print('End');
    // print(data.data!.first.title);
    // print(data.error);
    return data;
  }

}