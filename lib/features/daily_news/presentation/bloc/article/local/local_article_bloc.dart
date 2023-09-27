import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/features/daily_news/domain/usecases/get_saved_article.dart';
import 'package:flutter_clean_architecture/features/daily_news/domain/usecases/remove_local_article.dart';
import 'package:flutter_clean_architecture/features/daily_news/domain/usecases/save_local_article.dart';
import 'package:flutter_clean_architecture/features/daily_news/presentation/bloc/article/local/local_article_event.dart';
import 'package:flutter_clean_architecture/features/daily_news/presentation/bloc/article/local/local_article_state.dart';

class LocalArticleBloc extends Bloc<LocalArticlesEvent, LocalArticlesState> {
  final GetSavedArticleUseCase _getSavedArticlesUseCase;
  final SaveArticleUseCase _saveArticlesUseCase;
  final RemoveArticleUseCase _removeArticleUseCase;

  LocalArticleBloc(
    this._getSavedArticlesUseCase,
    this._saveArticlesUseCase,
    this._removeArticleUseCase,
  ) : super(const LocalArticlesLoading()) {
    on<GetSavedArticles>(onGetSavedArticles);
    on<RemoveArticle>(onRemoveArticle);
    on<SaveArticle>(onSaveArticle);
  }

  void onGetSavedArticles(GetSavedArticles getSavedArticlesEvent, Emitter<LocalArticlesState> emit) async {
    print('onGetSavedArticles');
    final articles = await _getSavedArticlesUseCase.call();
    print(articles);
    emit(LocalArticlesDone(articles));
  }

  Future<void> onRemoveArticle(RemoveArticle removeArticleEvent, Emitter<LocalArticlesState> emit) async {
    print('onRemoveArticle');
    await _removeArticleUseCase.call(param: removeArticleEvent.article);
    final articles = await _getSavedArticlesUseCase.call();
    emit(LocalArticlesDone(articles));
  }

  Future<void> onSaveArticle(SaveArticle saveArticleEvent, Emitter<LocalArticlesState> emit) async {
    print('onSaveArticle');
    await _saveArticlesUseCase.call(param: saveArticleEvent.article);
    final articles = await _getSavedArticlesUseCase.call();
    print(articles);
    emit(LocalArticlesDone(articles));
  }
}
