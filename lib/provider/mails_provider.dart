import 'package:consultation_app/services/mail_api_controller.dart';
import 'package:flutter/cupertino.dart';

import '../model/mail.dart';
enum MailsState { Initial, Loading, Loaded, Error }

class MailProvider extends ChangeNotifier {
  MailsState _state = MailsState.Initial ;
  MailsState get  state=> _state;

     List<Mails>? _mails ;
     List<Mails>?  get allMails=>  _mails ;
  final MailApiController _mailApiController = MailApiController();


  MailProvider() {
    getAllMails();
  }

  Future<void> getAllMails() async {
    _state = MailsState.Loading ;
    try {
      final repo = await _mailApiController.getAllMails();
      _mails = repo.data.mails;
      _state = MailsState.Loaded ;

    } catch (e) {
      _state = MailsState.Error ;
    }
    notifyListeners();

  }
}
