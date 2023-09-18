import 'dart:convert';
import 'dart:io';
import 'package:consultation_app/core/helper/api_helper.dart';
import 'package:consultation_app/core/helper/response_model.dart';
import 'package:consultation_app/core/utils/constants.dart';
import 'package:consultation_app/model/tag.dart';
import 'package:consultation_app/model/tag_create.dart';
import 'package:http/http.dart' as http;
import '../core/helper/shared_perf.dart';
import '../model/user.dart';

class TagApiController {
  Future<ResponseModel> getAllTags() async {
    User userAuth = userFromJson(SharedPerfController().userAuth);

    Uri uri = Uri.parse(tagsUrl);
    var response = await http.get(uri, headers: {
      HttpHeaders.authorizationHeader: 'Bearer ${userAuth.token}',
    });
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var jsonArray = TagModel.fromJson(jsonResponse);
      return ResponseModel(data: jsonArray, message: 'success');
    }
    return ResponseModel(message: 'failed');
  }

  Future<ApiHelper> createTags({required String name}) async {
    User userAuth = userFromJson(SharedPerfController().userAuth);

    Uri uri = Uri.parse(tagsUrl);
    var response = await http.post(uri, body: {
 'name' :name,
    },headers: {
      HttpHeaders.authorizationHeader: 'Bearer ${userAuth.token}',
    });
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      return ApiHelper(jsonResponse['message'], true);
    }
    return const ApiHelper('Something error ,try again', false);
  }
}