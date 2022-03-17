class NewsInfoModel {
  final String? imageURL;
  final String title;
  final DateTime dateTime;
  final String? content;
  final String? author;
  const NewsInfoModel({
    this.imageURL,
    required this.title,
    required this.dateTime,
    this.content,
    this.author,
  });

  factory NewsInfoModel.fromMap(Map<String, dynamic> m) {
    return NewsInfoModel(
      title: m['title'] ?? '-- Title --',
      dateTime: DateTime.parse(m['publishedAt']),
      author: m['author'],
      content: m['content'],
      imageURL: m['urlToImage'],
    );
  }
}
