import 'package:get_it/get_it.dart';
import '../service/cacher_service.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  final cacheService = CacheService();
  await cacheService.init();
  getIt.registerSingleton<CacheService>(cacheService);
}
