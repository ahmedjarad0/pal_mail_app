import 'package:consultation_app/provider/category_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CategoryView extends StatefulWidget {
  const CategoryView({super.key,  this.indexCategory, });
final int ?indexCategory ;
  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
 late int? selectedIndex  =widget.indexCategory;

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
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30.r),
                ),
                child: Consumer<CategoryProvider>(
                  builder: (context, categoryProvider, child) {
                    if (categoryProvider.state == CategoryState.Loading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (categoryProvider.state == CategoryState.Error) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    final category = categoryProvider.category;
                    if (category != null &&
                        categoryProvider.state == CategoryState.Complete) {
                      return ListView.separated(

                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) {
                          return const Divider(
                            thickness: 1,
                            height: 20,
                          );
                        },
                        shrinkWrap: true,
                        itemCount: category.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                selectedIndex = category[index].id!;

                              });
                            },
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    category[index].name!,
                                    style: GoogleFonts.poppins(fontSize: 16.sp),
                                  ),
                                  selectedIndex == category[index].id
                                      ? const Icon(
                                          Icons.check,
                                          color: Colors.blue,
                                          size: 20,
                                        )
                                      : const SizedBox(),
                                ]),
                          );
                        },
                      );
                    } else {
                      return const Center(
                        child: Text('No Data'),
                      );
                    }
                  },
                ))
          ],
        ),
      ),
    );
  }
}
