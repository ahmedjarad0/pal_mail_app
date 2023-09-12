import 'package:consultation_app/core/helper/api_response.dart';
import 'package:consultation_app/model/statues.dart';
import 'package:consultation_app/services/statues_api_controller.dart';
import 'package:flutter/cupertino.dart';

class StatusProvider extends ChangeNotifier {
  late ApiResponse<List<Statuses>> _status;

  ApiResponse <List<Statuses>>get status => _status;

  StatusProvider(){
    getStatus() ;
  }

  final StatuesApiController _statuesApiController = StatuesApiController();

  Future<void> getStatus() async {
    _status = ApiResponse.loading('loading');
    notifyListeners();
    try {
      final repo = await _statuesApiController.getAllStatues();
      _status = ApiResponse.completed(repo);
      notifyListeners();
    } catch (e) {
      _status = ApiResponse.error(e.toString());
      notifyListeners();
    }
  }
}
