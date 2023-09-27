import 'package:flutter_clean_architecture/features/daily_news/domain/entities/article.dart';
import 'package:flutter_clean_architecture/features/daily_news/domain/repositories/article_repository.dart';
import 'package:flutter_clean_architecture/features/daily_news/domain/usecases/usecase.dart';

class GetSavedArticleUseCase implements UseCase<List<ArticleEntity>, void> {
  final ArticleRepository _articleRepository;

  const GetSavedArticleUseCase(this._articleRepository);
  
  @override
  Future<List<ArticleEntity>> call({void param}) {
    return _articleRepository.getSavedArticles();
  }
}