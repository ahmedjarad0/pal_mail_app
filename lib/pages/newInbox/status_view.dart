import 'package:consultation_app/core/utils/constants.dart';
import 'package:consultation_app/pages/newInbox/new_inbox_view.dart';
import 'package:consultation_app/provider/status_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class StatusView extends StatefulWidget {
  static String id = '/status_view';
  const StatusView({super.key,   this.controller, });
final ScrollController? controller ;
  @override
  State<StatusView> createState() => _StatusViewState();
}

class _StatusViewState extends State<StatusView> {
 int? selectedIndex ;

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
                  Consumer<StatusProvider>(
                    builder: (context, statusProvider, child) {
                      if (statusProvider.state == StatusesState.Loading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (statusProvider.state == StatusesState.Error) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      final status = statusProvider.statuses;
                      if (status != null &&
                          statusProvider.state == StatusesState.Complete) {
                        return Expanded(
                          child: ListView.separated(
                            controller: widget.controller,
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
                                    selectedIndex = status[index].id!;
                                    Future.delayed(const Duration(milliseconds:250),(){
                                      Navigator.pushNamed(context,NewInbox.id,arguments: {
                                        'name': status[index].name,
                                        'color':status[index].color ,
                                      } );
                                    });
                                  });
                                },
                                child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 32,
                                        width: 32,
                                        decoration: BoxDecoration(
                                            color:  Color(int.parse(status[index].color!)),
                                            borderRadius:
                                                BorderRadius.circular(10.r)),
                                      ),
                                      SizedBox(
                                        width: 16.w,
                                      ),
                                      Text(
                                        status[index].name!,
                                        style: GoogleFonts.poppins(
                                            fontSize: 16.sp),
                                      ),
                                      const Spacer(),
                                      selectedIndex == status[index].id
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
                        );
                      } else {
                        return const Center(
                          child: Text('No Data'),
                        );
                      }
                    },
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
