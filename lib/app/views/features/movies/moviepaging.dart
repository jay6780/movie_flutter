import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:free_movie/app/model/movie.dart';
import 'package:free_movie/app/utils/app_colors.dart';
import 'package:free_movie/bloc/movie_pagination/moviepagination_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';

class Moviepaging extends StatefulWidget {
  String? title;
  int position;
  Moviepaging({super.key, required this.title, required this.position});

  @override
  MoviePagingUiState createState() => MoviePagingUiState();
}

class MoviePagingUiState extends State<Moviepaging> {
  late RefreshController _refreshController;
  late ScrollController scrollController;
  bool isFirst = true;
  int page = 1;
  bool isBuild = false;
  int position = 1;
  late List<Results> viewall = [];
  @override
  void initState() {
    super.initState();
    position = widget.position;
    isFirst = true;
    _refreshController = RefreshController(initialRefresh: false);
    scrollController = ScrollController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MoviepaginationBloc>().add(
        MoviepaginationfetchEvent(page: page, position: position),
      );
    });

    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        page++;

        context.read<MoviepaginationBloc>().add(
          MoviepaginationfetchEvent(page: page, position: position),
        );
      }
    });
  }

  void _onRefresh() async {
    context.read<MoviepaginationBloc>().add(
      MoviepaginationfetchEvent(page: 1, position: position),
    );
    isFirst = false;
    page = 1;
    if (viewall.isNotEmpty) {
      viewall.clear();
    }
    await Future.delayed(Duration(milliseconds: 500));
    _refreshController.refreshCompleted();
  }

  @override
  void dispose() {
    super.dispose();
    _refreshController.dispose();
    scrollController.dispose();
    page = 1;
    viewall.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        automaticallyImplyLeading: false,
        title: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: SvgPicture.asset(
                    'image/icon_backwhite.svg',
                    width: 25.0,
                    height: 25.0,
                  ),
                ),
              ),

              Align(
                alignment: Alignment.center,
                child: Container(
                  margin: EdgeInsets.only(top: 13),
                  child: Text(
                    widget.title.toString(),
                    style: GoogleFonts.firaSansCondensed(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: BlocConsumer<MoviepaginationBloc, MoviepaginationState>(
        listener: (context, state) {
          if (state is MoviepaginationSuccess) {
            if (_refreshController.isRefresh) {
              _refreshController.refreshCompleted();
            }
            if (state.allList.isNotEmpty) {
              viewall.addAll(state.allList);
            }
          } else if (state is MoviepaginationFailure) {
            if (_refreshController.isRefresh) {
              _refreshController.refreshFailed();
            }
          }
        },
        builder: (context, state) {
          return SmartRefresher(
            scrollController: scrollController,
            enablePullDown: true,
            enablePullUp: true,
            header: ClassicHeader(
              refreshingIcon: SizedBox(
                width: 25,
                height: 25,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
                ),
              ),
            ),

            footer: ClassicFooter(
              loadingIcon: SizedBox(
                width: 25,
                height: 25,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
                ),
              ),
            ),

            controller: _refreshController,
            onRefresh: _onRefresh,

            child: _createpagination(context, viewall),
          );
        },
      ),
    );
  }

  Widget _createpagination(BuildContext context, List<Results> viewall) =>
      GridView.custom(
        controller: scrollController,
        gridDelegate: SliverWovenGridDelegate.count(
          crossAxisCount: 2,
          mainAxisSpacing: 3,
          crossAxisSpacing: 3,
          pattern: [
            WovenGridTile(0.7),
            WovenGridTile(
              7 / 9,
              crossAxisRatio: 1.0,
              alignment: AlignmentDirectional.centerEnd,
            ),
          ],
        ),
        childrenDelegate: SliverChildBuilderDelegate(
          (context, index) => _buildMangaCard(context, viewall[index]),
          childCount: viewall.length,
        ),
      );
}

Widget _buildMangaCard(BuildContext context, Results results) {
  String imageItem = results.getPosterPath.toString();
  final String thumpUrl = 'https://image.tmdb.org/t/p/w500/$imageItem';
  return Card(
    elevation: 50,
    shadowColor: AppColors.onBackground,
    color: AppColors.white,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(7.0),
            child: CachedNetworkImage(
              imageUrl: thumpUrl,
              placeholder: (context, url) => Shimmer.fromColors(
                baseColor: AppColors.grey,
                highlightColor: AppColors.grey,
                child: Container(color: AppColors.white),
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            results.getTitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: GoogleFonts.robotoCondensed(
              fontSize: 15.00,
              color: AppColors.onBackground,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    ),
  );
}
