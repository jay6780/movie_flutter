import 'package:flutter/material.dart';
import 'package:free_movie/app/views/home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_movie/bloc/movielist_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MovielistBloc()..add(MoviefetchEvent()),
      child: MaterialApp(home: const Home()),
    );
  }
}
