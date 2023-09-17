import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryView extends StatefulWidget {
  const CategoryView({super.key});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  int? selectedIndex;

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
          'Category',
          style: GoogleFonts.poppins(fontSize: 14.sp, color: Colors.black),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 170,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30.r),
              ),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Official organization',
                            style: GoogleFonts.poppins(fontSize: 16.sp),
                          ),
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
            )
          ],
        ),
      ),
    );
  }
}
