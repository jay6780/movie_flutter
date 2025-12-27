import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:free_movie/app/utils/app_colors.dart';
import 'package:free_movie/app/views/widgets/selector.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  late bool isMovies = false;
  int _page = 1;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  @override
  void initState() {
    super.initState();
    isMovies = true;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      CurvedNavigationBarState? navBarState = _bottomNavigationKey.currentState;
      navBarState?.setPage(1);
    });

    return Scaffold(
      backgroundColor: AppColors.background,
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: AppColors.background,
        buttonBackgroundColor: AppColors.bottomnav,
        color: AppColors.bottomnav,
        key: _bottomNavigationKey,
        items: <Widget>[
          SvgPicture.asset('image/search.svg', width: 20.0, height: 20.0),
          SvgPicture.asset('image/home.svg', width: 20.0, height: 20.0),
          SvgPicture.asset('image/bookmark.svg', width: 20.0, height: 20.0),
        ],
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
      ),

      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.background,
        title: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Row(
            spacing: 100,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Image.asset(
                  'image/hamburger.png',
                  width: 30.0,
                  height: 30.0,
                ),
              ),
              Text(
                "PinoyFlix",
                style: GoogleFonts.firaSansCondensed(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
      body: _getPage(_page),
    );
  }
}

Widget _getPage(int page) {
  switch (page) {
    case 0:
      return Center(
        child: Text(
          "Search page",
          style: GoogleFonts.firaSansCondensed(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      );
    case 1:
      return Selector();
    case 2:
      return Center(
        child: Text(
          "Bookmarks",
          style: GoogleFonts.firaSansCondensed(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      );
    default:
      return Selector();
  }
}
