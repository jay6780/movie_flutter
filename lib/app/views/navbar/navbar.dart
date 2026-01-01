import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:free_movie/app/utils/app_colors.dart';
import 'package:free_movie/app/views/navbar/downloads.dart';
import 'package:google_fonts/google_fonts.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.background,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(top: 30.0),
                child: ClipOval(
                  child: SvgPicture.asset(
                    width: 100.00,
                    height: 100.00,
                    'image/app_icon.svg',
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 30.0, left: 10.0),
                child: Text(
                  "PinoyFlix",
                  style: GoogleFonts.firaSansCondensed(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 10.0),
            color: AppColors.white,
            width: MediaQuery.of(context).size.width,
            height: 1.0,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(builder: (context) => Downloads()),
              );
            },
            child: Container(
              margin: EdgeInsets.only(top: 5.0),
              child: Row(
                children: [
                  SvgPicture.asset(
                    width: 40.00,
                    height: 40.00,
                    'image/video_icon.svg',
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 3.0),
                    child: Text(
                      "Download videos",
                      style: GoogleFonts.firaSansCondensed(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
