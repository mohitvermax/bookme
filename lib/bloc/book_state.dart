part of 'book_bloc.dart';

abstract class BookState {}

class BookInitial extends BookState {}

class BookLoading extends BookState {}

class BookLoaded extends BookState {
  final List<Book> books;
  final bool hasReachedEnd;

  BookLoaded({required this.books, required this.hasReachedEnd});
}

class BookError extends BookState {
  final String message;
  BookError({required this.message});
}
