import 'package:consultation_app/core/utils/constants.dart';
import 'package:consultation_app/pages/widgets/custom_primary_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterView extends StatefulWidget {
  static String id = '/register_view';

  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();

  void checkSignUp(){
    if(_formKey.currentState!.validate()){

    }
  }
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(
            height: 50.h,
          ),
          TextFormField(
            validator: (value) {
              if (value != null && value.isEmpty) {
                return 'Please enter password';
              }  else {
                return null;
              }
            },
            decoration: InputDecoration(
                hintText: 'Enter email or username',
                hintStyle: GoogleFonts.poppins(
                  fontSize: 12,
                )),
          ),
          SizedBox(
            height: 30.h,
          ),
          TextFormField(
              validator: (value) {
                if (value != null && value.isEmpty) {
                  return 'Please enter password';
                } else if (value!.length < 6) {
                  return 'you have to enter at least 6 digit!';
                } else {
                  return null;
                }
              },

            decoration: InputDecoration(
                hintText: 'Password',
                hintStyle: GoogleFonts.poppins(
                  fontSize: 12,
                )),
          ),
          SizedBox(
            height: 30.h,
          ),
          TextFormField(
            validator: (value) {
              if (value != null && value.isEmpty) {
                return 'Please enter password';
              } else if (value!.length < 6) {
                return 'you have to enter at least 6 digit!';
              } else {
                return null;
              }
            },

            decoration: InputDecoration(
                hintText: 'Confirm Password',
                hintStyle: GoogleFonts.poppins(
                  fontSize: 12,
                )),
          ),
          SizedBox(
            height: 60.h,
          ),
          CustomPrimaryBtn(title: 'Sign Up', onPressed: () {
            checkSignUp();
          }),
          SizedBox(
            height: 33.h,
          ),
          Text(
            'OR',
            style: GoogleFonts.poppins(
                fontSize: 14.sp, color: const Color(0xffA8A7A7)),
          ),
          SizedBox(height: 15.h,),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
            SvgPicture.asset(facebookImage),
            SvgPicture.asset(twitterImage),
            SvgPicture.asset(googleImage),
          ],)
        ],
      ),
    );
    ;
  }
}
