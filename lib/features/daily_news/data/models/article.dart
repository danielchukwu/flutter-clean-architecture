import 'package:flutter_clean_architecture/features/daily_news/domain/entities/article.dart';
import 'package:floor/floor.dart';

@Entity(tableName: 'article', primaryKeys: ['id'])
class ArticleModel extends ArticleEntity {
  const ArticleModel({
    int? id,
    String? title,
    String? author,
    String? description,
    String? url,
    String? urlToImage,
    String? publishedAt,
    String? content,
  }) : super(
          id: id,
          title: title,
          author: author,
          description: description,
          url: url,
          urlToImage: urlToImage,
          publishedAt: publishedAt,
        );

  factory ArticleModel.fromJson(Map<String, dynamic> map) {
    return ArticleModel(
      id: map["id"] ?? 0,
      title: map["title"] ?? "",
      author: map["author"] ?? "",
      description: map["description"] ?? "",
      content: map["content"] ?? "",
      url: map["url"] ?? "",
      urlToImage: map["urlToImage"] ?? "",
      publishedAt: map["publishedAt"] ?? "",
    );
  }

  factory ArticleModel.fromEntity(ArticleEntity entity) => ArticleModel(
    id: entity.id,
    title: entity.title,
    author: entity.author,
    description: entity.description,
    url: entity.url,
    urlToImage: entity.urlToImage,
    publishedAt: entity.publishedAt,
    content: entity.content,
  );
}
