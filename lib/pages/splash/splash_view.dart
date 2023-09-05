import 'package:cached_network_image/cached_network_image.dart';
import 'package:consultation_app/core/helper/shared_perf.dart';
import 'package:consultation_app/pages/auth/login_view.dart';
import 'package:consultation_app/pages/tabBar/tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/utils/constants.dart';
import '../home/home_view.dart';

class SplashView extends StatefulWidget {
  static String id = '/splash_view';

  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(
      const Duration(seconds: 1),
      () {
        String route =
            SharedPerfController().loggedIn ? HomeScreen.id : ReTabBarView.id;
        Navigator.pushReplacementNamed(context, route);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: AlignmentDirectional.center,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: AlignmentDirectional.topStart,
              end: AlignmentDirectional.bottomStart,
              colors: [
                Color(0xff003AFC),
                Color(0xff587FFF),
              ]),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // CachedNetworkImage(
            //   imageUrl: palestineAsset,
            //   width: 76.w,
            //   height: 103.h,
            //
            // )
            Image.asset(
              palestineAsset,
              width: 76.w,
              height: 103.h,
            ),

            SizedBox(
              height: 18.h,
            ),
            Text(
              'ديوان رئيس الوزراء',
              style: GoogleFonts.saira(
                  fontSize: 30.sp, color: const Color(0xffFFFFFF)),
            )
          ],
        ),
      ),
    );
  }
}
