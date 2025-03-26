class Article {
  final int id;
  final String title;
  final String body;
  final String thumbnailUrl;
  final DateTime publishedDate;
  final String status;

  const Article({
    required this.id,
    required this.title,
    required this.body,
    required this.thumbnailUrl,
    required this.publishedDate,
    required this.status,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    // Zamieniamy protokół HTTP na HTTPS w URL miniaturki
    String correctedThumbnailUrl =
        (json['thumbnail'] as String).replaceFirst('http://', 'https://');

    return Article(
      id: json['id'] ?? 0,
      title: json['title'] as String,
      body: json['body'] as String,
      thumbnailUrl: correctedThumbnailUrl,
      publishedDate: DateTime.parse(json['published_date'] as String),
      status: json['status'] as String,
    );
  }
}
