import 'package:consultation_app/core/utils/constants.dart';
import 'package:consultation_app/pages/home/home_view.dart';
import 'package:consultation_app/pages/home/search_view.dart';
import 'package:consultation_app/pages/tabBar/tab_bar_view.dart';
import 'package:consultation_app/pages/splash/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          theme: ThemeData(
            useMaterial3: false,
              scaffoldBackgroundColor: kScaffoldColor,

              appBarTheme: AppBarTheme(
                iconTheme: const IconThemeData(
                  color: Colors.black
                ),
                scrolledUnderElevation: 0,
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  titleTextStyle:
                      GoogleFonts.poppins(color: kAppBarColor, fontSize: 18))),
          debugShowCheckedModeBanner: false,
          initialRoute: HomeScreen.id,
          routes: {
            SplashView.id: (context) => const SplashView(),
            ReTabBarView.id: (context) => const ReTabBarView(),
            HomeScreen.id: (context) => const HomeScreen(),
            SearchView.id: (context) => const SearchView(),
          },
        );
      },
    );
  }
}
