import 'package:flutter/material.dart';
import 'package:free_movie/app/views/widgets/home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_movie/bloc/movie/movielist_bloc.dart';
import 'package:free_movie/bloc/tvseries/tvseries_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MovielistBloc()..add(MoviefetchEvent(page: 1)),
        ),
        BlocProvider(
          create: (context) => TvseriesBloc()..add(TvseriesfetchEvent(page: 1)),
        ),
      ],
      child: MaterialApp(home: const Home()),
    );
  }
}
