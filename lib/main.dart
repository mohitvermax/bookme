import 'package:bookapp/bloc/book_bloc.dart';
import 'package:bookapp/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookBloc(),
      child: MaterialApp(
        title: 'Book Me!',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          scaffoldBackgroundColor: Colors.grey[50],
        ),
        home: const HomePage(),
      ),
    );
  }
}
