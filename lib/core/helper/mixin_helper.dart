import 'package:consultation_app/core/helper/api_helper.dart';
import 'package:flutter/material.dart';

mixin Helper {
  void snackBar(BuildContext context,
      {required String message, required bool success }) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: success ? Colors.green.shade500 : Colors.red.shade500,
    ));
  }
  ApiHelper get successApi => const ApiHelper('Operation Successfully', true);
  ApiHelper get errorApi => const ApiHelper('Operation failed', false);

}