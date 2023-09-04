import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
class CustomPrimaryBtn extends StatelessWidget {
  const CustomPrimaryBtn({
    required this.title ,
    required this.onPressed ,
    super.key,
  });
  final String title ;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: AlignmentDirectional.center,
        width: 264.w,
        height: 48.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22.r),
          gradient: const LinearGradient(
              begin: AlignmentDirectional.bottomStart,
              end: AlignmentDirectional.bottomEnd,
              colors: [
                Color(0xff003AFC),
                Color(0xff587FFF),
              ]),
        ),
        child: ElevatedButton(
          onPressed:onPressed,
          style: ElevatedButton.styleFrom(
              minimumSize: Size(
                264.w,
                48.h,
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22.r))),
          child: Text(
            title,
            style: GoogleFonts.poppins(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white),
          ),
        ));
  }
}
