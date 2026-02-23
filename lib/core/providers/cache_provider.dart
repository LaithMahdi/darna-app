import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../helper/cacher_helper.dart';

final cacherHelperProvider = Provider<CacherHelper>((ref) {
  return CacherHelper();
});

final isOnboardingCompletedProvider = Provider<bool>((ref) {
  final cacheHelper = ref.watch(cacherHelperProvider);
  return cacheHelper.isOnboardingCompleted();
});

final isCompletProfileProvider = Provider<bool>((ref) {
  final cacheHelper = ref.watch(cacherHelperProvider);
  return cacheHelper.isCompletProfile();
});
