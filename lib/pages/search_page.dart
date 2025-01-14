import 'package:bookapp/bloc/book_bloc.dart';
import 'package:bookapp/pages/book_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          style: const TextStyle(color: Colors.black),
          decoration: const InputDecoration(
            hintText: 'Search books...',
            hintStyle: TextStyle(color: Colors.grey),
            border: InputBorder.none,
          ),
          onSubmitted: (query) {
            if (query.isNotEmpty) {
              context.read<BookBloc>().add(SearchBooks(query));
            }
          },
        ),
      ),
      body: BlocBuilder<BookBloc, BookState>(
        builder: (context, state) {
          if (state is BookLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is BookLoaded) {
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.books.length,
              itemBuilder: (context, index) {
                final book = state.books[index];

                return ListTile(
                  leading: Image.network(
                    book.thumbnail,
                    width: 50,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.book),
                  ),
                  title: Text(book.title),
                  subtitle: Text(book.authors.join(', ')),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookDetailPage(book: book),
                      ),
                    );
                  },
                );
              },
            );
          }

          return const Center(child: Text('Search for books'));
        },
      ),
    );
  }
}
