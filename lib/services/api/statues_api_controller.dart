import 'dart:convert';
import 'dart:io';

import 'package:consultation_app/core/utils/constants.dart';
import 'package:consultation_app/model/statues.dart';
import 'package:http/http.dart' as http;

import '../../core/helper/shared_perf.dart';
import '../../model/user.dart';

class StatuesApiController {
  Future<List<Status>> getAllStatues() async {
    User userAuth = userFromJson(SharedPerfController().userAuth);

    Uri uri = Uri.parse(statusesUrl);
    var response = await http.get(uri, headers: {
      HttpHeaders.authorizationHeader: 'Bearer ${userAuth.token}',
    });
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var jsonArray = jsonResponse['statuses'] as List<dynamic>;
      return jsonArray.map((e) => Status.fromJson(e)).toList();
    }
    return [];
  }
}
