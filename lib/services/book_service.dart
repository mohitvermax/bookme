import 'package:bookapp/models/book.dart';
import 'package:dio/dio.dart';

class BookService {
  final Dio _dio = Dio();
  final String _baseUrl = 'https://www.googleapis.com/books/v1/volumes';

  Future<List<Book>> getBooks(int startIndex, {String? query}) async {
    try {
      final response = await _dio.get(
        _baseUrl,
        queryParameters: {
          'q': query ?? 'subject:fiction',
          'startIndex': startIndex,
          'maxResults': 20,
        },
      );
      // print(response);

      var items = response.data['items'] as List;
      final bookList = items.map((item) => Book.fromJson(item)).toList();

      return bookList;
    } catch (e) {
      throw Exception('Failed to load books');
    }
  }
}
