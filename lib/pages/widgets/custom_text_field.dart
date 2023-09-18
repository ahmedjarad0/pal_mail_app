import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hintText,
    this.controller,
    this.prefixIcon,
    this.suffixIcon, this.onPressedIcon,
  });

  final String hintText;

  final TextEditingController? controller;

  final IconData? prefixIcon;

  final Widget? suffixIcon;
  final   Function()? onPressedIcon ;
  @override
  Widget build(BuildContext context) {
    return TextField(
      onTapOutside: (v) {
        FocusScope.of(context).unfocus();

      },
      controller: controller,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.zero,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade100),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade100),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade100),
          ),
          prefixIcon:  Icon(
            prefixIcon ,
            color: const Color(0xffAFAFAF),
          ),
          hintText: hintText,
          hintStyle: GoogleFonts.poppins(color: const Color(0xffAFAFAF)),
          suffixIcon: suffixIcon),
    );
  }
}
