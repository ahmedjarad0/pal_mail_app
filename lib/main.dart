import 'package:consultation_app/core/helper/shared_perf.dart';
import 'package:consultation_app/core/utils/constants.dart';
import 'package:consultation_app/pages/home/home_view.dart';
import 'package:consultation_app/pages/newInbox/category_view.dart';
import 'package:consultation_app/pages/newInbox/new_inbox_view.dart';
import 'package:consultation_app/pages/home/search_view.dart';
import 'package:consultation_app/pages/auth/tab_bar_view.dart';
import 'package:consultation_app/pages/newInbox/status_view.dart';
import 'package:consultation_app/pages/splash_view.dart';
import 'package:consultation_app/provider/category_provider.dart';
import 'package:consultation_app/provider/mails_provider.dart';
import 'package:consultation_app/provider/status_provider.dart';
import 'package:consultation_app/provider/tag_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPerfController().initPerf();
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
        return MultiProvider(
          providers: [
            ChangeNotifierProvider<StatusProvider>(
              create: (context) => StatusProvider(),
            ),
            ChangeNotifierProvider<CategoryProvider>(
              create: (context) => CategoryProvider(),
            ),ChangeNotifierProvider<MailProvider>(
              create: (context) => MailProvider(),
            ),ChangeNotifierProvider<TagProvider>(
              create: (context) => TagProvider(),
            ),
          ],
          child: MaterialApp(
            theme: ThemeData(
                scaffoldBackgroundColor: kScaffoldColor,
                appBarTheme: AppBarTheme(
                    iconTheme: const IconThemeData(color: Colors.black),
                    scrolledUnderElevation: 0,
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    titleTextStyle: GoogleFonts.poppins(
                        color: kAppBarColor, fontSize: 18))),
            debugShowCheckedModeBanner: false,
            initialRoute: SplashView.id,
            routes: {
              SplashView.id: (context) => const SplashView(),
              ReTabBarView.id: (context) => const ReTabBarView(),
              HomeScreen.id: (context) => const HomeScreen(),
              SearchView.id: (context) => const SearchView(),
              NewInbox.id: (context) => const NewInbox(),
              StatusView.id: (context) => const StatusView(),
              CategoryView.id: (context) => const CategoryView(),
            },
          ),
        );
      },
    );
  }
}
