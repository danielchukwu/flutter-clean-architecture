import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/config/theme/app_themes.dart';
import 'package:flutter_clean_architecture/features/daily_news/domain/entities/article.dart';
import 'package:flutter_clean_architecture/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'package:flutter_clean_architecture/features/daily_news/presentation/bloc/article/remote/remote_article_event.dart';
import 'package:flutter_clean_architecture/features/daily_news/presentation/pages/article_detail/article_detail.dart';
import 'package:flutter_clean_architecture/features/daily_news/presentation/pages/home/daily_news.dart';
import 'package:flutter_clean_architecture/features/daily_news/presentation/pages/saved_article/saved_article.dart';
import 'package:flutter_clean_architecture/injection_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<RemoteArticlesBloc>(
      create: (context) => sl()..add(const GetArticles()),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: theme(),
        onGenerateRoute: AppRoute.onGenerateRoutes,
        home: const DailyNews(),
      ),
    );
  }
}

class AppRoute {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch(settings.name) {
      case '/': 
        return MaterialPageRoute(builder: (_) => const DailyNews(),);
      case '/article-details':
        return MaterialPageRoute(builder: (_) => ArticleDetailsView(article: settings.arguments as ArticleEntity),);
      case '/saved-article': 
        return MaterialPageRoute(builder: (_) => const SavedArticles());
      default:
        return MaterialPageRoute(builder: (_) => const DailyNews(),);
    }
  }
}