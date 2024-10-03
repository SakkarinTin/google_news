import 'dart:convert';

import 'package:google_news/app/data/models/article_model.dart';

class News {
  final List<Article>? articles;

  News({this.articles});

  factory News.fromRawJson(String str) => News.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory News.fromJson(Map<String, dynamic> json) => News(
        articles: json["items"] == null
            ? []
            : List<Article>.from(
                json["items"]!.map((x) => Article.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "articles": articles == null
            ? []
            : List<dynamic>.from(articles!.map((x) => x.toJson())),
      };

  @override
  String toString() {
    return 'News(articles: ${articles?.map((article) => article.toString()).toList()})';
  }
}
