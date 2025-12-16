class Article {
  final String title;
  final String? description;
  final String? imageUrl;
  final String? source;
  final String url;  final DateTime? publishedAt;

  final String? content;

  Article({
    required this.title,
    this.description,
    this.imageUrl,
    this.source,
    required this.url, // 👈 REQUIRED
    this.publishedAt,
    this.content,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'] ?? '',
      description: json['description'],
      imageUrl: json['urlToImage'],
      source: json['source']?['name'],
      url: json['url'],
      publishedAt: json['publishedAt'] != null
          ? DateTime.parse(json['publishedAt'])
          : null,
      content: json['content'],
    );
  }
}
