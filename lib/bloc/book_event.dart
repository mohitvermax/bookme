part of 'book_bloc.dart';

abstract class BookEvent {}

class LoadBooks extends BookEvent {
  final bool refresh;
  LoadBooks({this.refresh = false});
}

class SearchBooks extends BookEvent {
  final String query;
  SearchBooks(this.query);
}
