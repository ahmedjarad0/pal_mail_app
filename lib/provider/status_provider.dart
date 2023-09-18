import 'package:consultation_app/model/statues.dart';
import 'package:consultation_app/services/statues_api_controller.dart';
import 'package:flutter/cupertino.dart';
enum StatusesState { Initial, Loading, Complete, Error }

class StatusProvider extends ChangeNotifier {
  StatusesState _state = StatusesState.Initial;
  StatusesState get state => _state;
List<Statuses>? _statuses;
  List<Statuses>? get statuses=> _statuses;




  StatusProvider(){
    getStatus() ;
  }

  final StatuesApiController _statuesApiController = StatuesApiController();

  Future<void> getStatus() async {
    _state = StatusesState.Loading;
    notifyListeners();

    try {
      final repo = await _statuesApiController.getAllStatues();
      _statuses = repo.data.statuses;
      _state =StatusesState.Complete;
      notifyListeners();

    } catch (e) {
      _state =StatusesState.Error;
      notifyListeners();

    }

  }
}
