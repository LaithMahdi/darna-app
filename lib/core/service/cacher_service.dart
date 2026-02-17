import 'package:shared_preferences/shared_preferences.dart';

class CacheService {
  late SharedPreferences sharedPreferences;

  CacheService._privateConstructor();

  static final CacheService _instance = CacheService._privateConstructor();

  factory CacheService() {
    return _instance;
  }

  Future<CacheService> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    return this;
  }
}
