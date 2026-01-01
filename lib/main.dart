import 'dart:io';

import 'package:flutter/material.dart';
import 'package:free_movie/app/views/widgets/home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_movie/bloc/movie/movielist_bloc.dart';
import 'package:free_movie/bloc/movie_pagination/moviepagination_bloc.dart';
import 'package:free_movie/bloc/tvseries/tvseries_bloc.dart';
import 'package:free_movie/bloc/tvseries_pagination/tvseriespaging_bloc.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    deleteCache(context);
    return MultiBlocListener(
      listeners: [
        BlocProvider(
          create: (context) => MovielistBloc()..add(MoviefetchEvent(page: 1)),
        ),
        BlocProvider(
          create: (context) => TvseriesBloc()..add(TvseriesfetchEvent(page: 1)),
        ),
        BlocProvider(create: (context) => MoviepaginationBloc()),
        BlocProvider(create: (context) => TvseriespagingBloc()),
      ],
      child: MaterialApp(home: const Home()),
    );
  }

  static Future<bool> deleteDir(FileSystemEntity dir) async {
    if (dir == null) return false;
    try {
      if (await dir.exists()) {
        if (dir is Directory) {
          final List<FileSystemEntity> children = dir.listSync();

          for (final FileSystemEntity child in children) {
            await deleteDir(child);
          }

          await dir.delete();
          return true;
        } else if (dir is File) {
          await dir.delete();
          return true;
        }
      }
      return false;
    } catch (e) {
      print('Error deleting directory: $e');
      return false;
    }
  }

  static Future<void> deleteCache(BuildContext context) async {
    try {
      final cacheDir = await getTemporaryDirectory();
      await deleteDir(cacheDir);
    } catch (e) {
      // Handle exception
    }
  }
}
