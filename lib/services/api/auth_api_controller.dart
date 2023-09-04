import 'dart:convert';

import 'package:consultation_app/core/helper/api_helper.dart';
import 'package:consultation_app/core/helper/shared_perf.dart';
import 'package:consultation_app/core/utils/constants.dart';
import 'package:http/http.dart' as http;

import '../../model/uesr.dart';

class AuthApiController {
  Future<ApiHelper> login(String email, String password) async {
    Uri uri = Uri.parse(loginUrl);
    var response = await http.post(uri, body: {
      'email': email,
      'password': password,
    });
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      User user = User.fromJson(jsonResponse);
      SharedPerfController().save(user);
      return const ApiHelper('Operation Successfully', true);
    }
    return const ApiHelper('Operation failed', false);
  }

  Future<ApiHelper> register({required Map<String, dynamic> body}) async {
    Uri uri = Uri.parse(registerUrl);
    var response = await http.post(uri, body: body);
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 201) {
      var jsonResponse = jsonDecode(response.body);
      User user = User.fromJson(jsonResponse['user']);
      SharedPerfController().save(user);
      return ApiHelper(jsonResponse['message'], true);
    }
    return const ApiHelper('Operation failed', false);
  }
}
