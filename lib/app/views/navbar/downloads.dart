import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:free_movie/app/utils/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class Downloads extends StatelessWidget {
  const Downloads({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.background,
        title: Stack(
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                alignment: Alignment.centerLeft,
                child: SvgPicture.asset(
                  width: 25.00,
                  height: 25.00,
                  'image/icon_backwhite.svg',
                ),
              ),
            ),

            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 3.0),
              child: Text(
                "Downloads",
                style: GoogleFonts.firaSansCondensed(
                  color: AppColors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 1.0,
            color: AppColors.white,
          ),
          Center(
            child: Text(
              "Downloads",
              style: GoogleFonts.firaSansCondensed(
                color: AppColors.white,
                fontSize: 18.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
