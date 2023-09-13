import 'package:consultation_app/model/category.dart';
import 'package:consultation_app/services/category_api_controller.dart';
import 'package:flutter/cupertino.dart';

enum CategoryState { Initial, Loading, Loaded, Error }

class CategoryProvider extends ChangeNotifier {
  CategoryState _state =CategoryState.Initial;

  CategoryState get state => _state;
  List<Categories>? _category;

  List<Categories>? get category => _category;
  final CategoryApiController _categoryApiController = CategoryApiController();

  CategoryProvider() {
    getAllCategory();
  }

  Future<void> getAllCategory() async {
    _state = CategoryState.Loading;
    try {
      final repo = await _categoryApiController.getCategories();
      _category = repo.data.categories ;
      _state = CategoryState.Loaded ;
    } catch (e) {
      _state = CategoryState.Error;
    }
    notifyListeners();

  }
}
