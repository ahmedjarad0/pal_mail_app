import 'package:consultation_app/core/helper/mixin_helper.dart';
import 'package:consultation_app/core/utils/constants.dart';
import 'package:consultation_app/pages/splash/splash_view.dart';
import 'package:consultation_app/pages/widgets/custom_primary_btn.dart';
import 'package:consultation_app/services/api/auth_api_controller.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/helper/api_helper.dart';

class RegisterView extends StatefulWidget {
  static String id = '/register_view';

  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> with Helper {
  late TextEditingController _nameCtl;
  late TextEditingController _emailCtl;
  late TextEditingController _passwordCtl;
  late TextEditingController _confirmPasswordCtl;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameCtl = TextEditingController();
    _emailCtl = TextEditingController();
    _passwordCtl = TextEditingController();
    _confirmPasswordCtl = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _nameCtl.dispose();
    _emailCtl.dispose();
    _passwordCtl.dispose();
    _confirmPasswordCtl.dispose();
    super.dispose();
  }

  void checkSignUp(context) async {
    Map<String, dynamic> body = {
      'email': _emailCtl.text,
      'password': _passwordCtl.text,
      'password_confirmation': _confirmPasswordCtl.text,
      'name': _nameCtl.text,
    };
    if (_formKey.currentState!.validate()) {
      ApiHelper apiHelper = await AuthApiController().register(body: body);
      if (apiHelper.success) {
        Navigator.pushReplacementNamed(context, SplashView.id);
      }
      snackBar(context, message: apiHelper.message, success: apiHelper.success);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20.h,
            ),
            TextFormField(
              controller: _nameCtl,
              validator: (value) {
                if (value != null && value.isEmpty) {
                  return 'Please enter name';
                } else if (value!.length < 4) {
                  return 'you have to enter at least 4 digit!';
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                  hintText: 'name',
                  hintStyle: GoogleFonts.poppins(
                    fontSize: 12,
                  )),
            ),
            SizedBox(
              height: 15.h,
            ),
            TextFormField(
              controller: _emailCtl,
              validator: (value) {
                if (EmailValidator.validate(value!)) {
                  return null;
                } else {
                  return 'please enter the email';
                }
              },
              decoration: InputDecoration(
                  hintText: 'Enter email',
                  hintStyle: GoogleFonts.poppins(
                    fontSize: 12,
                  )),
            ),
            SizedBox(
              height: 15.h,
            ),
            TextFormField(
              controller: _passwordCtl,
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
              height: 15.h,
            ),
            TextFormField(
              controller: _confirmPasswordCtl,
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
              height: 25.h,
            ),
            CustomPrimaryBtn(
                title: 'Sign Up',
                onPressed: () {
                  checkSignUp(context);
                }),
            SizedBox(
              height: 15.h,
            ),
            Text(
              'OR',
              style: GoogleFonts.poppins(
                  fontSize: 14.sp, color: const Color(0xffA8A7A7)),
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SvgPicture.asset(facebookImage,height: 20),
                SvgPicture.asset(twitterImage,height: 20),
                SvgPicture.asset(googleImage,height: 20),
              ],
            )
          ],
        ),
      ),
    );
    ;
  }
}
