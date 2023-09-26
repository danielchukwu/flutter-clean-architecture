import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/core/resources/data_state.dart';
import 'package:flutter_clean_architecture/features/daily_news/domain/usecases/get_article.dart';
import 'package:flutter_clean_architecture/features/daily_news/presentation/bloc/article/remote/remote_article_event.dart';
import 'package:flutter_clean_architecture/features/daily_news/presentation/bloc/article/remote/remote_article_state.dart';

class RemoteArticlesBloc extends Bloc<RemoteArticlesEvent, RemoteArticleState> {
  final GetArticlesUseCase _getArticleUseCase;

  RemoteArticlesBloc(this._getArticleUseCase): super(const RemoteArticlesLoading()) {
    on<GetArticles> (onGetArticles);
  }

  Future<void> onGetArticles(GetArticles event, Emitter<RemoteArticleState> emit) async {
    var dataState = await _getArticleUseCase();

    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(RemoteArticlesDone(dataState.data!));
    }

    if (dataState is DataFailed) {
      emit(RemoteArticlesError(dataState.error!));
    }
  }
}
