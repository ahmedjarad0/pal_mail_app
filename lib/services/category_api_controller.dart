import 'dart:convert';
import 'dart:io';

import 'package:consultation_app/core/helper/response_model.dart';
import 'package:consultation_app/core/utils/constants.dart';
import 'package:http/http.dart' as http;

import '../core/helper/shared_perf.dart';
import '../model/category.dart';
import '../model/user.dart';

class CategoryApiController {
  Future<ResponseModel> getCategories() async {
    User userAuth = userFromJson(SharedPerfController().userAuth);
    Uri uri = Uri.parse(categoriesUrl);
    var response = await http.get(uri, headers: {
      HttpHeaders.authorizationHeader: 'Bearer ${userAuth.token}',
    });
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var jsonObject = CategoryModel.fromJson(jsonResponse);
      return ResponseModel(data: jsonObject,message: 'success');
    }
    return ResponseModel(message: 'failed');
  }
}
