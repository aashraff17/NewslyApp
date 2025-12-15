class Article {
  final String title;
  final String description;
  final String imageUrl;
  final String source;
  final String url;
  final DateTime publishedAt;

  Article({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.source,
    required this.url,
    required this.publishedAt,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['image'] ?? '',
      source: json['source']['name'] ?? '',
      url: json['url'],
      publishedAt: DateTime.parse(json['publishedAt']),
    );
  }
}
