import 'dart:convert';
import 'dart:io';

import 'package:consultation_app/core/utils/constants.dart';
import 'package:consultation_app/model/tags.dart';
import 'package:http/http.dart' as http;

import '../../core/helper/shared_perf.dart';
import '../../model/user.dart';

class TagApiController {
  Future<List<Tag>> getAllTags() async {
    User userAuth = userFromJson(SharedPerfController().userAuth);

    Uri uri = Uri.parse(tagsUrl);
    var response = await http.get(uri, headers: {
      HttpHeaders.authorizationHeader: 'Bearer ${userAuth.token}',
    });
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var jsonArray = jsonResponse['tags'] as List;
      return jsonArray.map((jsonObject) => Tag.fromJson(jsonObject)).toList();
    }
    return [];
  }
}
