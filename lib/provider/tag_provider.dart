import 'package:consultation_app/services/tag_api_controller.dart';
import 'package:flutter/cupertino.dart';

import '../model/mail.dart';

enum TagStatues { Initial, Loading, Loaded, Error }

class TagProvider extends ChangeNotifier {
  TagStatues _statues = TagStatues.Initial;

  TagStatues get statues => _statues;
  List<Tags>? _tag;

  List<Tags>? get tag => _tag;
  final TagApiController _apiController = TagApiController();

  Future<void> getAllTags() async {
    _statues = TagStatues.Loading;
    try {
      final res = await _apiController.getAllTags();
      _tag = res.data.tags;
      _statues = TagStatues.Loaded;
    } catch (e) {
      _statues = TagStatues.Error;
    }
    notifyListeners();
  }
}
