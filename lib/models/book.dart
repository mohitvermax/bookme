class Book {
  final String id;
  final String title;
  final List<String> authors;
  final String publishedDate;
  final String language;
  final int pageCount;
  final String description;
  final String thumbnail;

  Book({
    required this.id,
    required this.title,
    required this.authors,
    required this.publishedDate,
    required this.language,
    required this.pageCount,
    required this.description,
    required this.thumbnail,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    var volumeInfo = json['volumeInfo'];
    var imageLinks = volumeInfo['imageLinks'] ?? {};

    return Book(
      id: json['id'] ?? '',
      title: volumeInfo['title'] ?? '',
      authors: List<String>.from(volumeInfo['authors'] ?? []),
      description: volumeInfo['description'] ?? '',
      thumbnail: imageLinks['thumbnail'],
      publishedDate: volumeInfo["publishedDate"],
      pageCount: volumeInfo["pageCount"],
      language: volumeInfo["language"],
    );
  }
}
