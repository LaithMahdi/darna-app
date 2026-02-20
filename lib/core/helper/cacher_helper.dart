import 'package:get_it/get_it.dart';
import '../service/cacher_service.dart';

class CacherHelper {
  final _service = GetIt.instance.get<CacheService>();
  final String _isOnboardingCompletedKey = 'is_onboarding_completed';
  final String _isCompletProfileKey = 'is_complet_profile';

  CacherHelper();

  Future<void> setOnboardingCompleted(bool value) async {
    await _service.sharedPreferences.setBool(_isOnboardingCompletedKey, value);
  }

  bool isOnboardingCompleted() {
    return _service.sharedPreferences.getBool(_isOnboardingCompletedKey) ??
        false;
  }

  Future<void> setCompletProfile(bool value) async {
    await _service.sharedPreferences.setBool(_isCompletProfileKey, value);
  }

  bool isCompletProfile() {
    return _service.sharedPreferences.getBool(_isCompletProfileKey) ?? false;
  }

  // Clear data
  Future<void> deleteData() async {}

  // Clear all app data
  Future<void> clearAllData() async {}
}
