import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextFieldNewIndex extends StatelessWidget {
  const CustomTextFieldNewIndex({
    super.key,
    this.hintText,
    this.controller,
    this.labelText,
    this.onTap,
    this.style,
    this.prefixIcon, this.suffixIcon, this.prefix,
  });

  final String? hintText;

  final TextEditingController? controller;

  final String? labelText;

  final TextStyle? style;

  final void Function()? onTap;

  final Widget? prefixIcon;
  final Widget? prefix;
  final Widget? suffixIcon;


  @override
  Widget build(BuildContext context) {
    return TextField(
      style: style,
      controller: controller,
      onTapOutside: (v) {
        FocusScope.of(context).unfocus();
      },
      onTap: onTap,
      decoration: InputDecoration(
        prefix: prefix,
        hintStyle: GoogleFonts.poppins(
            color: const Color(0xffAFAFAF), fontSize: 14.sp),
        hintText: hintText,
        labelText: labelText,
        labelStyle: GoogleFonts.poppins(color: Colors.black,fontSize: 22.sp),
 prefixIcon: prefixIcon,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        border: InputBorder.none,
        errorBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        suffixIcon: suffixIcon,
      ),
    );
  }
}
