import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
class StatusCard extends StatelessWidget {
  const StatusCard({
    super.key, required this.title, required this.color, required this.idCount,

  });
 final String title ;
 final int color ;
final String idCount ;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 5.h),
              blurRadius: 3.sp)
        ],
        borderRadius: BorderRadius.circular(29.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: 8.r,
                backgroundColor:
                Color(color),
              ),
              Text(
                idCount  ,
                style: GoogleFonts.poppins(fontSize: 16.sp),
              ),
            ],
          ),
          Text(
          title  ,
            style: GoogleFonts.poppins(fontSize: 14.sp),
          ),
        ],
      ),
    );
  }
}