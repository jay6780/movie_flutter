import 'package:flutter/material.dart';
import 'package:free_movie/app/utils/app_colors.dart';
import 'package:free_movie/app/views/moviepage.dart';
import 'package:google_fonts/google_fonts.dart';

class Movieseries extends StatefulWidget {
  Movieseries({super.key});

  @override
  MovieseriesState createState() => MovieseriesState();
}

class MovieseriesState extends State<Movieseries> {
  late bool isMovies = true;
  @override
  void initState() {
    super.initState();
    isMovies = true;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 10.0),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  if (!isMovies) {
                    setState(() {
                      isMovies = true;
                    });
                  }
                },
                child: Text(
                  "Movies",
                  style: GoogleFonts.firaSansCondensed(
                    fontSize: 16.0,
                    color: isMovies ? AppColors.select_color : AppColors.white,
                  ),
                ),
              ),
              SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  if (isMovies) {
                    setState(() {
                      isMovies = false;
                    });
                  }
                },
                child: Text(
                  "Tv series",
                  style: GoogleFonts.firaSansCondensed(
                    fontSize: 16.0,
                    color: !isMovies ? AppColors.select_color : AppColors.white,
                  ),
                ),
              ),
            ],
          ),
        ),

        Expanded(
          child: isMovies
              ? Moviepage()
              : Container(
                  color: AppColors.background,
                  child: Center(
                    child: Text(
                      "TV Series Coming Soon",
                      style: GoogleFonts.firaSansCondensed(
                        fontSize: 16.0,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}
