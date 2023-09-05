import 'package:consultation_app/core/helper/api_helper.dart';
import 'package:consultation_app/core/helper/mixin_helper.dart';
import 'package:consultation_app/pages/splash/splash_view.dart';
import 'package:consultation_app/pages/widgets/custom_primary_btn.dart';
import 'package:consultation_app/services/api/auth_api_controller.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginView extends StatefulWidget {
  static String id = '/login_view';

  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> with Helper {
  late TextEditingController _emailCtl;

  late TextEditingController _passwordCtl;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailCtl = TextEditingController();
    _passwordCtl = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailCtl.dispose();
    _passwordCtl.dispose();
    super.dispose();
  }

  void checkLoggedIn(context) async {
    if (_formKey.currentState!.validate()) {
      ApiHelper apiHelper =
          await AuthApiController().login(_emailCtl.text, _passwordCtl.text);
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
      child: Column(
        children: [
          SizedBox(
            height: 50.h,
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
                hintText: 'Enter Email',
                hintStyle: GoogleFonts.poppins(
                  fontSize: 12,
                )),
          ),
          SizedBox(
            height: 30.h,
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
            height: 50.h,
          ),
          CustomPrimaryBtn(
              title: 'Login',
              onPressed: () {
                checkLoggedIn(context);
              }),
        ],
      ),
    );
  }
}
