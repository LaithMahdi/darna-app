import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
final class Env {
  @EnviedField(varName: 'FIREBASE_API_KEY_ANDROID', obfuscate: true)
  static final String firebaseApiKeyAndroid = _Env.firebaseApiKeyAndroid;

  @EnviedField(varName: 'FIREBASE_APP_ID_ANDROID')
  static final String firebaseAppIdAndroid = _Env.firebaseAppIdAndroid;

  @EnviedField(varName: 'FIREBASE_MESSAGING_SENDER_ID')
  static final String firebaseMessagingSenderId =
      _Env.firebaseMessagingSenderId;

  @EnviedField(varName: 'FIREBASE_PROJECT_ID')
  static final String firebaseProjectId = _Env.firebaseProjectId;

  @EnviedField(varName: 'FIREBASE_STORAGE_BUCKET')
  static final String firebaseStorageBucket = _Env.firebaseStorageBucket;

  @EnviedField(varName: 'FIREBASE_API_KEY_IOS', obfuscate: true)
  static final String firebaseApiKeyIos = _Env.firebaseApiKeyIos;

  @EnviedField(varName: 'FIREBASE_APP_ID_IOS')
  static final String firebaseAppIdIos = _Env.firebaseAppIdIos;

  @EnviedField(varName: 'FIREBASE_IOS_BUNDLE_ID')
  static final String firebaseIosBundleId = _Env.firebaseIosBundleId;

  @EnviedField(varName: 'FIREBASE_WEB_CLIENT_ID')
  static final String firebaseWebClientId = _Env.firebaseWebClientId;
}
