import 'package:consultation_app/core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class StatusView extends StatefulWidget {
  const StatusView({super.key});

  @override
  State<StatusView> createState() => _StatusViewState();
}

int? selectedIndex;

class _StatusViewState extends State<StatusView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leadingWidth: 65,
        leading: TextButton(
          child: Text(
            'Cancel',
            style: GoogleFonts.poppins(
              fontSize: 15.sp,
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Done',
              style: GoogleFonts.poppins(
                fontSize: 15.sp,
              ),
            ),
          ),
        ],
        title: Text(
          'Status',
          style: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.black),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 271,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30.r),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Add Status',
                        style: GoogleFonts.poppins(
                            fontSize: 16.sp, color: kLightPrimaryColor),
                      ),
                      const Icon(
                        Icons.edit_outlined,
                        size: 18,
                        color: Color(0xffAFAFAF),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 27.h,
                  ),
                  Expanded(
                    child: ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      separatorBuilder: (context, index) {
                        return const Divider(
                          thickness: 1,
                          height: 20,
                        );
                      },
                      shrinkWrap: true,
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                            });
                          },
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 32,
                                  width: 32,
                                  decoration: BoxDecoration(
                                      color: const Color(0xffFA3A57),
                                      borderRadius:
                                          BorderRadius.circular(10.r)),
                                ),
                                SizedBox(
                                  width: 16.w,
                                ),
                                Text(
                                  'Inbox',
                                  style: GoogleFonts.poppins(fontSize: 16.sp),
                                ),
                                const Spacer(),
                                selectedIndex == index
                                    ? const Icon(
                                        Icons.check,
                                        color: Colors.blue,
                                        size: 20,
                                      )
                                    : const SizedBox(),
                              ]),
                        );
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
