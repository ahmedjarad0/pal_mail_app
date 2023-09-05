import 'package:consultation_app/core/helper/api_helper.dart';
import 'package:consultation_app/core/helper/mixin_helper.dart';
import 'package:consultation_app/core/utils/constants.dart';
import 'package:consultation_app/model/item.dart';
import 'package:consultation_app/pages/home/search_view.dart';
import 'package:consultation_app/pages/splash/splash_view.dart';
import 'package:consultation_app/services/api/auth_api_controller.dart';
import 'package:consultation_app/services/api/statues_api_controller.dart';
import 'package:consultation_app/services/api/tag_api_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../model/statues.dart';
import '../../model/tags.dart';

class HomeScreen extends StatefulWidget {
  static String id = '/home_view';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with Helper {
  final List<Item> _item = <Item>[
    Item(headerValue: 'Official Organization', expandedValue: 'Ahmed'),
    Item(headerValue: 'NGOs', expandedValue: 'Mohammed'),
    Item(headerValue: 'Others', expandedValue: 'Mustafa'),
  ];
  final _advancedDrawerController = AdvancedDrawerController();
  final GlobalKey expansionTileKey = GlobalKey();
  String _content = '1';
  late double previousOffset;
  late Future<List<Tag>> tag;
  late Future<List<Status>> status;

  void test() async {}

  @override
  void initState() {
    status = StatuesApiController().getAllStatues();
    tag = TagApiController().getAllTags(); // TODO: implement initState
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
      drawer: SafeArea(
        child: ListTileTheme(
          textColor: Colors.white,
          iconColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Column(
              children: [
                Image.asset(
                  palestineAsset,
                ),
                SizedBox(
                  height: 55.h,
                ),
                ListTile(
                    onTap: () {},
                    leading: const Icon(Icons.home),
                    title: Text(
                      'Home',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                      ),
                    )),
                ListTile(
                  onTap: () {},
                  leading: const Icon(Icons.account_circle_rounded),
                  title: Text('Profile',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                      )),
                ),
                ListTile(
                  onTap: () {},
                  leading: const Icon(Icons.person_pin_rounded),
                  title: Text('Messengers',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                      )),
                ),
                ListTile(
                  onTap: () {},
                  leading: const Icon(Icons.settings),
                  title: Text('User management',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                      )),
                ),
                const Spacer(),
                DefaultTextStyle(
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.white54,
                  ),
                  child: Container(
                    margin: EdgeInsets.symmetric(
                      vertical: 16.0.h,
                    ),
                    child: const Text('Terms of Service | Privacy Policy'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
            leading: IconButton(
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
            ),
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
              PopupMenuButton<String>(
                offset: Offset(-20.h, 20.w),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r)),
                onSelected: (String value) {
                  setState(() {
                    _content = value;
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
                            style: GoogleFonts.poppins(
                                color: kHintColor, height: 1.h),
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
              ),
              SizedBox(
                width: 15.w,
              ),
            ]),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: FutureBuilder<List<Status>>(
                future: status,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasData) {
                    return GridView.builder(
                      physics: const ClampingScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16.r,
                          childAspectRatio: 181.w / 90.h,
                          mainAxisSpacing: 16.r),
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 10.h, horizontal: 15.w),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12,
                                  offset: Offset(0, 5.h),
                                  blurRadius: 3.sp)
                            ],
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CircleAvatar(
                                    radius: 15.r,
                                    backgroundColor: Color(int.parse(
                                        snapshot.data![index].color!)),
                                  ),
                                  Text(
                                    snapshot.data![index].id.toString(),
                                    style: GoogleFonts.poppins(fontSize: 19.sp),
                                  ),
                                ],
                              ),
                              Text(
                                snapshot.data![index].name!,
                                style: GoogleFonts.poppins(fontSize: 19.sp),
                              ),
                            ],
                          ),
                        );
                      },
                      itemCount: snapshot.data!.length,
                    );
                  } else {
                    return const Text('No Data');
                  }
                },
              ),
            ),
            SizedBox(
              height: 23.h,
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(15),
                children: [
                  ExpansionPanelList(
                      expandedHeaderPadding: EdgeInsets.zero,
                      animationDuration: const Duration(milliseconds: 300),
                      expansionCallback: (panelIndex, isExpanded) {
                        setState(() {
                          _item[panelIndex].isExpanded = !isExpanded;
                        });
                      },
                      elevation: 0,
                      children: _item.map((e) {
                        return ExpansionPanel(
                            canTapOnHeader: true,
                            backgroundColor: kScaffoldColor,
                            isExpanded: e.isExpanded,
                            headerBuilder: (context, isExpanded) {
                              return Text(
                                e.headerValue,
                                style: GoogleFonts.poppins(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w500),
                              );
                            },
                            body: ListView.builder(
                              physics: const ClampingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: 3,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: const EdgeInsets.only(bottom: 15),
                                  padding: EdgeInsets.only(
                                    bottom: 25.h,
                                    right: 20.w,
                                    left: 20.w,
                                    top: 10.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30.r),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 23.h,
                                            width: 12.w,
                                            decoration: const BoxDecoration(
                                                color: Colors.blueAccent,
                                                shape: BoxShape.circle),
                                          ),
                                          SizedBox(
                                            width: 9.w,
                                          ),
                                          Text(
                                            'Organization Name',
                                            style: GoogleFonts.poppins(
                                                fontSize: 18.sp),
                                          ),
                                          const Spacer(),
                                          Text(
                                            'Today, 11:00 AM',
                                            style: GoogleFonts.poppins(
                                                fontSize: 12.sp,
                                                color: kHintColor),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 7.h,
                                      ),
                                      Text(
                                        'Here we add the subject',
                                        textAlign: TextAlign.start,
                                        style: GoogleFonts.poppins(
                                            fontSize: 14.sp),
                                      ),
                                      Text(
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        softWrap: true,
                                        'And here excerpt of the mail, can ',
                                        style: GoogleFonts.poppins(
                                            fontSize: 14.sp,
                                            color: kLightPrimaryColor),
                                      ),
                                      SizedBox(
                                        height: 11.h,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            '#Urgent ',
                                            textAlign: TextAlign.start,
                                            style: GoogleFonts.poppins(
                                                fontSize: 14.sp,
                                                color: kLightPrimaryColor),
                                          ),
                                          Text(
                                            '#Egyptian Military',
                                            textAlign: TextAlign.start,
                                            style: GoogleFonts.poppins(
                                                fontSize: 14.sp,
                                                color: kLightPrimaryColor),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 7.h,
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                              width: 36.w,
                                              height: 36.h,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color:
                                                          Colors.grey.shade100),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.r)),
                                              child:
                                                  SvgPicture.asset(manImage)),
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              },
                            ));
                      }).toList()),
                  Text(
                    'Tags',
                    style: GoogleFonts.poppins(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 17.h,
                  ),
                  FutureBuilder<List<Tag>>(
                    future: tag,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasData) {
                        return Container(
                          padding: const EdgeInsets.all(15),
                          width: 378.w,
                          height: 100.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.r),
                            color: Colors.white,
                          ),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(4),
                                child: Wrap(
                                  spacing: 15,
                                  children:
                                      // Container(
                                      //   decoration: const BoxDecoration(
                                      //     color: kHintColor,
                                      //
                                      //   ),
                                      //   child: const Text('#Urgent '),
                                      // )
                                      [
                                    Chip(
                                      backgroundColor: kHintColor,
                                      labelStyle: GoogleFonts.montserrat(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10),
                                      label: Text(snapshot.data![index].name!),
                                      deleteIcon: const Icon(
                                        Icons.close,
                                        size: 24,
                                      ),
                                      deleteIconColor: Colors.red.shade300,
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        );
                      } else {
                        return const Text('No Data');
                      }
                    },
                  )
                ],
              ),
            ),
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
    );
  }

  Future<ApiHelper> userLogout(context) async {
    ApiHelper apiHelper = await AuthApiController().logout();
    if (apiHelper.success) {
      Navigator.pushNamedAndRemoveUntil(context, SplashView.id,(route) {
        return false ;
      },);
    }
    snackBar(context, message: apiHelper.message, success: apiHelper.success);
    return apiHelper;
  }
}
