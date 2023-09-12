import 'package:consultation_app/core/helper/api_response.dart';
import 'package:consultation_app/services/mail_api_controller.dart';
import 'package:flutter/cupertino.dart';

import '../model/mail.dart';

class MailProvider extends ChangeNotifier {
  late ApiResponse<List<Mails>> _mails;

  final MailApiController _mailApiController = MailApiController();

  ApiResponse<List<Mails>> get mails => _mails;

  MailProvider() {
    getAllMails();
  }

  Future<void> getAllMails() async {
    _mails = ApiResponse.loading('loading');
    notifyListeners();
    try {
      final repo = await _mailApiController.getAllMails();
      _mails = ApiResponse.completed(repo);
      notifyListeners();
    } catch (e) {
      _mails = ApiResponse.error(e.toString());
      notifyListeners();
    }
  }
}
