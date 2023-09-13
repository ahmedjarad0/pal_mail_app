import 'package:consultation_app/core/helper/api_helper.dart';
import 'package:consultation_app/core/helper/mixin_helper.dart';
import 'package:consultation_app/core/utils/constants.dart';
import 'package:consultation_app/model/mail.dart';
import 'package:consultation_app/pages/home/search_view.dart';
import 'package:consultation_app/pages/home/widget/content_expansion_tile.dart';
import 'package:consultation_app/pages/home/widget/custom_expansion_tile.dart';
import 'package:consultation_app/pages/home/widget/custom_gridview_consumer.dart';
import 'package:consultation_app/pages/splash_view.dart';
import 'package:consultation_app/provider/category_provider.dart';
import 'package:consultation_app/provider/mails_provider.dart';
import 'package:consultation_app/services/auth_api_controller.dart';
import 'package:consultation_app/services/category_api_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../provider/status_provider.dart';
import 'widget/advance_drawer.dart';

class HomeScreen extends StatefulWidget {
  static String id = '/home_view';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with Helper {
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
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(15),
                child: ConsumerStatusProvider(),
              ),
              SizedBox(
                height: 23.h,
              ),
              Consumer2<CategoryProvider, MailProvider>(
                  builder: (context, catValue, mailsValue, child) {
                if (catValue.state == CategoryState.Loading) {
                  return categoriesShimmer();
                }
                if (catValue.state == CategoryState.Error) {
                  return categoriesShimmer();
                }

                final categories = catValue.category;

                if (categories != null &&
                    catValue.state == CategoryState.Loaded) {
                  return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        List<Mails> filteredMails = [];

                        if (mailsValue.state == MailsState.Loaded) {
                          final mails = mailsValue.allMails;
                          filteredMails = mails!.where((e) {
                            return e.sender?.category!.name ==
                                categories[index].name;
                          }).toList();

                          return CustomExpansionTile(
                              title: categories[index].name!,
                              count: filteredMails.length.toString(),
                              child: ListView.separated(
                                itemCount: filteredMails.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  return ContentExpansionTile(
                                    color: filteredMails[index].status != null
                                        ? int.parse(
                                            filteredMails[index].status!.color!)
                                        : 0xff214283,
                                    title: filteredMails[index].sender!.name!,
                                    date: filteredMails[index].createdAt!,
                                    subject: filteredMails[index].subject!,
                                    description:
                                        filteredMails[index].description,
                                    tags: filteredMails[index]
                                        .tags!
                                        .map((e) => '#${e.name}   ')
                                        .toList()
                                        .join()
                                        .toString(),
                                    photoList: const SizedBox(),
                                  );
                                },
                                separatorBuilder: (context, index) =>
                                    const Divider(
                                  color: Colors.grey,
                                ),
                              ));
                        }
                        return const SizedBox();
                      });
                } else {
                  return categoriesShimmer();
                }
              }),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return BottomSheet(
                        onClosing: () {},
                        builder: (context) {
                          return const Column(
                            children: [Text('Ahmed')],
                          );
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
    );
  }

  Shimmer categoriesShimmer() {
    return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 4,
          itemBuilder: (context, index) {
            return Container(
                margin: const EdgeInsets.all(8),
                color: Colors.red,
                width: double.infinity,
                height: 50,
                child: Container(width: double.infinity));
          },
        ));
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
