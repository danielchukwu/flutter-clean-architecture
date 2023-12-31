import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'package:flutter_clean_architecture/features/daily_news/presentation/bloc/article/remote/remote_article_state.dart';
import 'package:flutter_clean_architecture/features/daily_news/presentation/widgets/article_tile.dart';

class DailyNews extends StatelessWidget {
  const DailyNews({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  _buildAppBar() {
    return AppBar(
      title: const Text(
        'Daily News',
      ),
    );
  }

  _buildBody() {
    return BlocBuilder<RemoteArticlesBloc, RemoteArticleState>(
      builder: (context, state) {
        // if loading
        if (state is RemoteArticlesLoading) {
          return const Center(child: CupertinoActivityIndicator());
        }

        // if error
        if (state is RemoteArticlesError) {
          return const Center(child: Icon(Icons.refresh));
        }

        // if loaded
        if (state is RemoteArticlesDone) {
          return ListView.builder(
            itemBuilder: (context, index) {
              // return ListTile(title: Text('$index'));
              return ArticleWidget(article: state.articles![index],);
            },
          );
        }

        return const SizedBox();
      },
    );
  }
}
