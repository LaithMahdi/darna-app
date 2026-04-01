import 'package:flutter/material.dart';

abstract class Config {
  static const String appName = 'Darna';
  static const String fontFamily = 'Raleway';
  static const String userCollection = 'users';
  static const String colocationsCollection = 'colocations';
  static const String tasksCollection = 'tasks';
  static const String notificationsCollection = 'notifications';
  static const String chatRoomsCollection = 'chatRooms';
  static const String messagesCollection = 'messages';
  static bool isDebugMode = false;
  static EdgeInsets defaultPadding = const EdgeInsets.all(25);
  static EdgeInsets paddingBottom = EdgeInsets.fromLTRB(25, 10, 25, 25);
  static const String privacyUrl = "assets/json/privacy.json";
  static const String termsConditionUrl =
      "assets/json/terms_and_condition.json";
}
