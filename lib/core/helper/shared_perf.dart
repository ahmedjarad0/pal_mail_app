import 'package:consultation_app/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum PerfKeys { loggedIn, token, user }

class SharedPerfController {
  SharedPerfController._();

  late SharedPreferences _sharedPreferences;

  static SharedPerfController? _instance;

  factory SharedPerfController() {
    return _instance ??= SharedPerfController._();
  }

  Future<void> initPerf() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> save(User user) async {
    await _sharedPreferences.setString(PerfKeys.user.name, userToJson(user));
    await _sharedPreferences.setString(PerfKeys.token.name, 'Bearer ${user.token}');
    await _sharedPreferences.setBool(PerfKeys.loggedIn.name, true);
  }

  Future<bool> clean() async {
    return await _sharedPreferences.clear();
  }

  String get userAuth => _sharedPreferences.getString(PerfKeys.user.name)!;

  String get token => _sharedPreferences.getString(PerfKeys.token.name)!;

  bool get loggedIn =>
      _sharedPreferences.getBool(PerfKeys.loggedIn.name) ?? false;
}
