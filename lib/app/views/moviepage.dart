import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_movie/app/model/movie.dart';
import 'package:free_movie/app/utils/app_colors.dart';
import 'package:free_movie/bloc/movielist_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class Moviepage extends StatelessWidget {
  const Moviepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocBuilder<MovielistBloc, MovielistState>(
        builder: (context, state) {
          switch (state.runtimeType) {
            case MovielistInitial:
            case MovielisLoading:
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              );
            case MovieFetchSuccess:
              final successState = state as MovieFetchSuccess;
              return _movies(
                context,
                popular: successState.popular,
                toprated: successState.toprated,
                nowPlaying: successState.nowPlaying,
                upcoming: successState.upcoming,
              );
            case PopularFailure:
              final errorState = state as PopularFailure;
              return Center(
                child: Text(
                  errorState.errorMessage,
                  style: GoogleFonts.firaSansCondensed(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              );
            default:
              return Container();
          }
        },
      ),
    );
  }

  Widget _movies(
    BuildContext context, {
    required List<Results> popular,
    required List<Results> toprated,
    required List<Results> nowPlaying,
    required List<Results> upcoming,
  }) {
    return CustomScrollView(
      slivers: [
        if (popular.isNotEmpty)
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.only(top: 10.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          "Popular",
                          style: GoogleFonts.firaSansCondensed(
                            fontSize: 16.0,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        margin: const EdgeInsets.only(right: 10.0),
                        child: Text(
                          "See all",
                          style: GoogleFonts.firaSansCondensed(
                            fontSize: 16.0,
                            color: AppColors.select_color,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    height: 170.0,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: popular.length,
                      itemBuilder: (context, index) {
                        final String imageItem = popular[index].getPosterPath;
                        final String imageUrl =
                            'https://image.tmdb.org/t/p/w500/$imageItem';
                        return Container(
                          width: MediaQuery.of(context).size.width * 0.28,
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            color: AppColors.mainColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Column(
                            children: <Widget>[
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5.0),
                                  child: CachedNetworkImage(
                                    imageUrl: imageUrl,
                                    placeholder: (context, url) =>
                                        Shimmer.fromColors(
                                          baseColor: AppColors.grey,
                                          highlightColor: AppColors.grey,
                                          child: Container(
                                            color: AppColors.white,
                                          ),
                                        ),
                                    errorWidget: (context, url, error) => Icon(
                                      Icons.error,
                                      color: AppColors.white,
                                    ),
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  popular[index].originalTitle.toString(),
                                  overflow: TextOverflow.fade,
                                  maxLines: 1,
                                  softWrap: false,
                                  style: GoogleFonts.robotoCondensed(
                                    fontSize: 15.00,
                                    color: AppColors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        if (toprated.isNotEmpty)
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.only(top: 10.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          "Top Rated",
                          style: GoogleFonts.firaSansCondensed(
                            fontSize: 16.0,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        margin: const EdgeInsets.only(right: 10.0),
                        child: Text(
                          "See all",
                          style: GoogleFonts.firaSansCondensed(
                            fontSize: 16.0,
                            color: AppColors.select_color,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    height: 170.0,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: toprated.length,
                      itemBuilder: (context, index) {
                        final String imageItem = toprated[index].getPosterPath;
                        final String imageUrl =
                            'https://image.tmdb.org/t/p/w500/$imageItem';
                        return Container(
                          width: MediaQuery.of(context).size.width * 0.28,
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            color: AppColors.mainColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Column(
                            children: <Widget>[
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5.0),
                                  child: CachedNetworkImage(
                                    imageUrl: imageUrl,
                                    placeholder: (context, url) =>
                                        Shimmer.fromColors(
                                          baseColor: AppColors.grey,
                                          highlightColor: AppColors.grey,
                                          child: Container(
                                            color: AppColors.white,
                                          ),
                                        ),
                                    errorWidget: (context, url, error) => Icon(
                                      Icons.error,
                                      color: AppColors.white,
                                    ),
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  toprated[index].originalTitle.toString(),
                                  overflow: TextOverflow.fade,
                                  maxLines: 1,
                                  softWrap: false,
                                  style: GoogleFonts.robotoCondensed(
                                    fontSize: 15.00,
                                    color: AppColors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        if (nowPlaying.isNotEmpty)
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.only(top: 10.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          "Now Playing",
                          style: GoogleFonts.firaSansCondensed(
                            fontSize: 16.0,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        margin: const EdgeInsets.only(right: 10.0),
                        child: Text(
                          "See all",
                          style: GoogleFonts.firaSansCondensed(
                            fontSize: 16.0,
                            color: AppColors.select_color,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    height: 170.0,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: nowPlaying.length,
                      itemBuilder: (context, index) {
                        final String imageItem =
                            nowPlaying[index].getPosterPath;
                        final String imageUrl =
                            'https://image.tmdb.org/t/p/w500/$imageItem';
                        return Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            color: AppColors.mainColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Stack(
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: BorderRadius.circular(5.0),
                                child: CachedNetworkImage(
                                  imageUrl: imageUrl,
                                  placeholder: (context, url) =>
                                      Shimmer.fromColors(
                                        baseColor: AppColors.grey,
                                        highlightColor: AppColors.grey,
                                        child: Container(
                                          color: AppColors.white,
                                        ),
                                      ),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error, color: AppColors.white),
                                  fit: BoxFit.fill,
                                  width: double.infinity,
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                child: Container(
                                  margin: const EdgeInsets.only(
                                    left: 5.0,
                                    bottom: 5.0,
                                  ),
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                          5.0,
                                        ),
                                        child: CachedNetworkImage(
                                          imageUrl: imageUrl,
                                          placeholder: (context, url) =>
                                              Shimmer.fromColors(
                                                baseColor: AppColors.grey,
                                                highlightColor: AppColors.grey,
                                                child: Container(
                                                  color: AppColors.white,
                                                ),
                                              ),
                                          errorWidget: (context, url, error) =>
                                              Icon(
                                                Icons.error,
                                                color: AppColors.white,
                                              ),
                                          fit: BoxFit.fill,
                                          width:
                                              MediaQuery.of(
                                                context,
                                              ).size.width *
                                              0.2,
                                          height:
                                              MediaQuery.of(
                                                context,
                                              ).size.width *
                                              0.3,
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(5.0),
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                            0.5,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              overflow: TextOverflow.fade,
                                              maxLines: 1,
                                              softWrap: false,
                                              nowPlaying[index]
                                                  .getOriginalTitle,
                                              style:
                                                  GoogleFonts.firaSansCondensed(
                                                    fontSize: 15.0,
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColors.white,
                                                  ),
                                            ),
                                            const SizedBox(height: 4.0),
                                            Text(
                                              maxLines: 3,
                                              overflow: TextOverflow.fade,
                                              softWrap: true,
                                              nowPlaying[index].getOverview,
                                              style:
                                                  GoogleFonts.firaSansCondensed(
                                                    fontSize: 13.0,
                                                    color: AppColors.white,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        if (upcoming.isNotEmpty)
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.only(top: 10.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          "Upcoming",
                          style: GoogleFonts.firaSansCondensed(
                            fontSize: 16.0,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        margin: const EdgeInsets.only(right: 10.0),
                        child: Text(
                          "See all",
                          style: GoogleFonts.firaSansCondensed(
                            fontSize: 16.0,
                            color: AppColors.select_color,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 5, bottom: 10),
                    height: 170.0,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: upcoming.length,
                      itemBuilder: (context, index) {
                        final String imageItem = upcoming[index].getPosterPath;
                        final String imageUrl =
                            'https://image.tmdb.org/t/p/w500/$imageItem';
                        return Container(
                          width: MediaQuery.of(context).size.width * 0.28,
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            color: AppColors.mainColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Column(
                            children: <Widget>[
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5.0),
                                  child: CachedNetworkImage(
                                    imageUrl: imageUrl,
                                    placeholder: (context, url) =>
                                        Shimmer.fromColors(
                                          baseColor: AppColors.grey,
                                          highlightColor: AppColors.grey,
                                          child: Container(
                                            color: AppColors.white,
                                          ),
                                        ),
                                    errorWidget: (context, url, error) => Icon(
                                      Icons.error,
                                      color: AppColors.white,
                                    ),
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  upcoming[index].originalTitle.toString(),
                                  overflow: TextOverflow.fade,
                                  maxLines: 1,
                                  softWrap: false,
                                  style: GoogleFonts.robotoCondensed(
                                    fontSize: 15.00,
                                    color: AppColors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
