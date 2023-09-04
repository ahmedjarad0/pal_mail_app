import 'package:consultation_app/pages/widgets/custom_primary_btn.dart';
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

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  void checkLoggedIn(){
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
              if(EmailValidator.validate(value!)){
                return null ;
              }else {
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
            height: 70.h,
          ),
          CustomPrimaryBtn(title: 'Login', onPressed: () {
                    checkLoggedIn();
          }),
        ],
      ),
    );
  }
}
