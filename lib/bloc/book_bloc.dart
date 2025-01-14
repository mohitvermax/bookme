import 'package:bookapp/models/book.dart';
import 'package:bookapp/services/book_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'book_event.dart';
part 'book_state.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  final BookService _bookService = BookService();
  int _currentPage = 0;
  String? _currentQuery;

  BookBloc() : super(BookInitial()) {
    on<LoadBooks>(_onLoadBooks);
    on<SearchBooks>(_onSearchBooks);
  }

  Future<void> _onLoadBooks(LoadBooks event, Emitter<BookState> emit) async {
    try {
      if (state is BookInitial || event.refresh) {
        emit(BookLoading());
        _currentPage = 0;
      }

      final books = await _bookService.getBooks(
        _currentPage * 20,
        query: _currentQuery,
      );

      _currentPage++;

      final currentBooks = (state is BookLoaded)
          ? [...(state as BookLoaded).books, ...books]
          : books;

      emit(BookLoaded(books: currentBooks, hasReachedEnd: books.isEmpty));
    } catch (e) {
      emit(BookError(message: e.toString()));
    }
  }

  Future<void> _onSearchBooks(
      SearchBooks event, Emitter<BookState> emit) async {
    _currentQuery = event.query;
    _currentPage = 0;
    add(LoadBooks(refresh: true));
  }
}
