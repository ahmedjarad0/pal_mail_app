import 'package:consultation_app/core/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/custom_text_field.dart';

class NewInbox extends StatefulWidget {
  static String id = '/new_inbox_view';

  const NewInbox({super.key});

  @override
  State<NewInbox> createState() => _NewInboxState();
}

class _NewInboxState extends State<NewInbox> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: kLightPrimaryColor,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Done',
              style: GoogleFonts.poppins(
                  fontSize: 18.sp, color: kLightPrimaryColor),
            ),
          ),
        ],
        title: Text(
          'New Inbox',
          style: GoogleFonts.poppins(fontSize: 18.sp, color: Colors.black),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Container(
              width: 378.w,
              height: 190.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.r),
                  color: Colors.white),
              child: const Column(
                children: [
                  CustomTextField(
                      hintText: 'Sender',
                      suffixIcon: Icons.info_outline,
                      prefixIcon: Icons.person_outline),
                  CustomTextField(
                      hintText: 'Mobile',
                      prefixIcon: Icons.send_to_mobile_outlined),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
