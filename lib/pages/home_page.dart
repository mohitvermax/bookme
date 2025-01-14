import 'package:bookapp/bloc/book_bloc.dart';
import 'package:bookapp/pages/search_page.dart';
import 'package:bookapp/widgets/book_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<BookBloc>().add(LoadBooks());
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      final state = context.read<BookBloc>().state;
      if (state is BookLoaded && !state.hasReachedEnd) {
        context.read<BookBloc>().add(LoadBooks());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Me!'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SearchPage()),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<BookBloc, BookState>(
        builder: (context, state) {
          if (state is BookInitial ||
              state is BookLoading && state is! BookLoaded) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is BookLoaded) {
            return GridView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: state.books.length + (state.hasReachedEnd ? 0 : 1),
              itemBuilder: (context, index) {
                if (index == state.books.length) {
                  return const Center(child: CircularProgressIndicator());
                }
                return BookCard(book: state.books[index]);
              },
            );
          }

          if (state is BookError) {
            return Center(child: Text(state.message));
          }

          return const SizedBox();
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
