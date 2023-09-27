

import 'package:flutter_clean_architecture/features/daily_news/domain/entities/article.dart';
import 'package:flutter_clean_architecture/features/daily_news/domain/repositories/article_repository.dart';
import 'package:flutter_clean_architecture/features/daily_news/domain/usecases/usecase.dart';

class SaveArticleUseCase implements UseCase<void,ArticleEntity>{
  
  final ArticleRepository _articleRepository;

  SaveArticleUseCase(this._articleRepository);
  
  @override
  Future<void> call({ArticleEntity ? param}) {
    return _articleRepository.saveArticle(param!);
  }
}