import 'package:consultation_app/core/helper/api_helper.dart';
import 'package:consultation_app/core/helper/mixin_helper.dart';
import 'package:consultation_app/core/utils/constants.dart';
import 'package:consultation_app/pages/home/new_inbox_view.dart';
import 'package:consultation_app/pages/home/search_view.dart';
import 'package:consultation_app/pages/home/widget/consumer_expansion_tile.dart';
import 'package:consultation_app/pages/home/widget/consumer_gridview.dart';
import 'package:consultation_app/pages/home/widget/consumer_tags.dart';
import 'package:consultation_app/pages/splash_view.dart';
import 'package:consultation_app/provider/category_provider.dart';
import 'package:consultation_app/provider/mails_provider.dart';
import 'package:consultation_app/provider/tag_provider.dart';
import 'package:consultation_app/services/auth_api_controller.dart';
import 'package:consultation_app/services/category_api_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../provider/status_provider.dart';
import 'widget/advance_drawer.dart';

class HomeScreen extends StatefulWidget {
  static String id = '/home_view';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with Helper {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  final _advancedDrawerController = AdvancedDrawerController();
  String content = '1';

  void test() async {
    await CategoryApiController().getCategories();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<StatusProvider>(context, listen: false).getStatus();
      Provider.of<CategoryProvider>(context, listen: false).getAllCategory();
      Provider.of<MailProvider>(context, listen: false).getAllMails();
      Provider.of<TagProvider>(context, listen: false).getAllTags();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      backdrop: Container(
        width: double.infinity,
        height: double.infinity,
        color: kPrimaryColor,
      ),
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      drawer: const AdvanceDrawer(),
      child: Scaffold(
        appBar: AppBar(
            leading: buildIconButtonDrawer(),
            centerTitle: true,
            title: Text(
              'Pal Mail',
              style: GoogleFonts.poppins(color: Colors.black),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, SearchView.id);
                  },
                  icon: const Icon(Icons.search)),
              SizedBox(
                width: 10.w,
              ),
              buildPopupMenuButton(),
              SizedBox(
                width: 15.w,
              ),
            ]),
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: () async {
              Provider.of<StatusProvider>(context, listen: false).getStatus();
              Provider.of<CategoryProvider>(context, listen: false)
                  .getAllCategory();
              Provider.of<MailProvider>(context, listen: false).getAllMails();
              Provider.of<TagProvider>(context, listen: false).getAllTags();
            },
            key: _refreshIndicatorKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ConsumerStatusProvider(),
                  SizedBox(
                    height: 23.h,
                  ),
                  //TODO: Consumer with CategoryProvider & MailProvider
                  const ConsumerExpansionTile(),
                  SizedBox(
                    height: 16.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Text(
                      'Tags',
                      style: Style.kTextStyle.copyWith(fontSize: 20.sp),
                    ),
                  ),
                  SizedBox(
                    height: 17.sp,
                  ),
                  //TODO: Consumer with TagsProvider
                  const ConsumerTags(),

                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        useSafeArea: true,
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                            borderRadius:BorderRadius.vertical(
                        top: Radius.circular(30.r),
                      ),),
                        context: context,
                        builder: (context) {
                          return DraggableScrollableSheet(
                            initialChildSize: 0.99,
                            maxChildSize: 0.99,
                            minChildSize: 0.99,
                            expand: true,
                            builder: (context, scrollController) {
                              return const NewInbox();
                            },
                          );
                        },
                      );
                    },
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            radius: 16,
                            backgroundColor: kLightPrimaryColor,
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Text(
                            'New Inbox ',
                            textAlign: TextAlign.start,
                            style: GoogleFonts.poppins(
                                fontSize: 20.sp, color: kLightPrimaryColor),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  PopupMenuButton<String> buildPopupMenuButton() {
    return PopupMenuButton<String>(
      offset: Offset(-20.h, 20.w),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      onSelected: (String value) {
        setState(() {
          content = value;
        });
      },
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            value: '1',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: CircleAvatar(
                      backgroundColor: Colors.grey.shade200,
                      radius: 35.r,
                      child: SvgPicture.asset(
                        appBarImage,
                        height: 60.h,
                      )),
                ),
                Center(
                    child: Text('Ahmed Jarad',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins())),
                Text(
                  'admin',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(color: kHintColor, height: 1.h),
                ),
              ],
            ),
          ),
          const PopupMenuDivider(),
          PopupMenuItem(
            padding: EdgeInsets.symmetric(horizontal: 20.h),
            value: '2',
            child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.language_outlined),
                title: Text('English',
                    style: GoogleFonts.poppins(color: kHintColor))),
          ),
          PopupMenuItem(
            padding: EdgeInsets.symmetric(horizontal: 20.h),
            value: '3',
            child: ListTile(
                onTap: () {
                  userLogout(context);
                },
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.logout),
                title: Text('Logout',
                    style: GoogleFonts.poppins(color: kHintColor))),
          ),
        ];
      },
      child: CircleAvatar(
          backgroundColor: Colors.white,
          radius: 20.h,
          child: SvgPicture.asset(
            appBarImage,
            height: 60.h,
          )),
    );
  }

  IconButton buildIconButtonDrawer() {
    return IconButton(
      onPressed: () {
        _advancedDrawerController.showDrawer();
      },
      icon: ValueListenableBuilder<AdvancedDrawerValue>(
        valueListenable: _advancedDrawerController,
        builder: (_, value, __) {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: Icon(
              value.visible ? Icons.clear : Icons.menu_open_sharp,
              key: ValueKey<bool>(value.visible),
            ),
          );
        },
      ),
    );
  }

  Future<ApiHelper> userLogout(context) async {
    ApiHelper apiHelper = await AuthApiController().logout();
    if (apiHelper.success) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        SplashView.id,
        (route) {
          return false;
        },
      );
    }
    snackBar(context, message: apiHelper.message, success: apiHelper.success);
    return apiHelper;
  }
}
