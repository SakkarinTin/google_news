import 'dart:convert';

class Article {
  final String? title;
  final String? snippet;
  final String? publisher;
  final String? timestamp;
  final String? newsUrl;
  final dynamic? images;
  final bool? hasSubnews;
  final List<Article>? subnews;

  Article({
    this.title,
    this.snippet,
    this.publisher,
    this.timestamp,
    this.newsUrl,
    this.images,
    this.hasSubnews,
    this.subnews,
  });

  factory Article.fromRawJson(String str) => Article.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Article.fromJson(Map<String, dynamic> json) => Article(
        title: json["title"] ?? "Title not found",
        snippet: json["snippet"] ?? "Snippet not found",
        publisher: json["publisher"] ?? "Publisher not found",
        timestamp: json["timestamp"] ?? "",
        newsUrl: json["newsUrl"] ?? "",
        images: json["images"] ?? "",
        hasSubnews: json["hasSubnews"] ?? false,
        subnews: json["subnews"] == null
            ? []
            : List<Article>.from(
                json["subnews"]!.map((x) => Article.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "snippet": snippet,
        "publisher": publisher,
        "timestamp": timestamp,
        "newsUrl": newsUrl,
        "images": images,
        "hasSubnews": hasSubnews,
        "subnews": subnews == null
            ? []
            : List<dynamic>.from(subnews!.map((x) => x.toJson())),
      };

  @override
  String toString() {
    return 'Article{title: $title, snippet: $snippet, publisher: $publisher, timestamp: $timestamp, newsUrl: $newsUrl, images: $images, hasSubnews: $hasSubnews, subnews: ${subnews?.map((sub) => sub.toString()).toList()}}';
  }
}
