import 'package:consultation_app/core/helper/api_response.dart';
import 'package:consultation_app/model/category.dart';
import 'package:consultation_app/services/category_api_controller.dart';
import 'package:flutter/cupertino.dart';

class CategoryProvider extends ChangeNotifier {
  late ApiResponse<List<Categories>> _categories;

  final CategoryApiController _categoryApiController = CategoryApiController();

  ApiResponse<List<Categories>> get categories => _categories;

  CategoryProvider() {
    getAllCategory();
  }

  Future<void> getAllCategory() async {
    _categories = ApiResponse.loading('loading');
    notifyListeners();
    try {
      final repo = await _categoryApiController.getCategories();
      _categories = ApiResponse.completed(repo);
      notifyListeners();
    } catch (e) {
      _categories = ApiResponse.error(e.toString());
      notifyListeners();
    }
  }
}
