import 'dart:convert';
import 'dart:io';

import 'package:consultation_app/core/helper/response_model.dart';
import 'package:consultation_app/core/utils/constants.dart';
import 'package:http/http.dart' as http;

import '../core/helper/shared_perf.dart';
import '../model/mail.dart';
import '../model/user.dart' ;

class MailApiController {
  Future<ResponseModel> getAllMails() async {
    print('hello');
   final userAuth = userFromJson(SharedPerfController().userAuth);
    Uri uri = Uri.parse(mailsUrl);
    var response = await http.get(uri, headers: {
      HttpHeaders.authorizationHeader: 'Bearer ${userAuth.token}',
    });
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var jsonObject  = MailModel.fromJson(jsonResponse);
      return ResponseModel(data: jsonObject,message: 'Success');
    }
    return ResponseModel(message: 'failed');
  }
}
