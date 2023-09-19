import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/utils/constants.dart';
class AdvanceDrawer extends StatelessWidget {
  const  AdvanceDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
    );
  }

}
