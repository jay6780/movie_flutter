import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:free_movie/app/model/tvseries.dart';
import 'package:free_movie/app/utils/app_colors.dart';
import 'package:free_movie/bloc/tvseries_pagination/tvseriespaging_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';

class Tvpaging extends StatefulWidget {
  String? title;
  int position;
  Tvpaging({super.key, required this.title, required this.position});

  @override
  MoviePagingUiState createState() => MoviePagingUiState();
}

class MoviePagingUiState extends State<Tvpaging> {
  late RefreshController _refreshController;
  late ScrollController scrollController;
  int page = 1;
  int position = 1;
  bool nomore = false;
  late List<Results> viewall = [];
  @override
  void initState() {
    super.initState();
    position = widget.position;
    _refreshController = RefreshController(initialRefresh: false);
    scrollController = ScrollController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TvseriespagingBloc>().add(
        TvseriespagingfetchEvent(page: page, position: position),
      );
    });

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (nomore) {
          return;
        }
        _loadmore();
      }
    });
  }

  void _scrollToTopAnimated() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        0.0,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  void _loadmore() async {
    page++;
    context.read<TvseriespagingBloc>().add(
      TvseriespagingfetchEvent(page: page, position: position),
    );
    _refreshController.loadComplete();
  }

  void _onRefresh() async {
    page = 1;
    nomore = false;
    viewall.clear();

    context.read<TvseriespagingBloc>().add(
      TvseriespagingfetchEvent(page: 1, position: position),
    );
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
              Container(
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

              Container(
                margin: EdgeInsets.only(top: 13),
                alignment: Alignment.center,
                child: Text(
                  widget.title.toString(),
                  style: GoogleFonts.firaSansCondensed(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () {
                    _scrollToTopAnimated();
                  },
                  icon: SvgPicture.asset(
                    'image/refresh.svg',
                    width: 25.0,
                    height: 25.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 1,
            color: AppColors.white,
          ),
          Expanded(
            child: BlocConsumer<TvseriespagingBloc, TvseriespagingState>(
              listener: (context, state) {
                if (state is TvseriespagingSuccess) {
                  if (state.allList.isNotEmpty) {
                    viewall.addAll(state.allList);
                    nomore = false;
                  } else {
                    nomore = true;
                    _refreshController.loadNoData();
                  }
                } else if (state is TvseriespagingFailure) {
                  if (_refreshController.isRefresh) {
                    _refreshController.refreshFailed();
                  }
                }
              },
              builder: (context, state) {
                return SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: true,
                  header: ClassicHeader(
                    refreshingIcon: SizedBox(
                      width: 25,
                      height: 25,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.white,
                        ),
                      ),
                    ),
                  ),

                  footer: ClassicFooter(
                    loadingIcon: SizedBox(
                      width: 25,
                      height: 25,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.white,
                        ),
                      ),
                    ),
                  ),

                  controller: _refreshController,
                  onRefresh: _onRefresh,

                  child: _createpagination(context, viewall),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _createpagination(BuildContext context, List<Results> viewall) =>
      GridView.custom(
        controller: scrollController,
        gridDelegate: SliverWovenGridDelegate.count(
          crossAxisCount: 3,
          mainAxisSpacing: 1,
          crossAxisSpacing: 1,
          pattern: [
            WovenGridTile(0.6),
            WovenGridTile(
              5 / 7,
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
            results.getOriginalName.toString(),
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
