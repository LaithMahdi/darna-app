import 'dart:convert';
import 'package:flutter/services.dart';
import '../../features/privacyAndTermsCondition/models/privacy_model.dart';
import '../config.dart';

class LoadDataFromJson {
  Future<List<PrivacyModel>> loadPrivacy() async {
    // Load JSON string from assets
    String jsonString = await rootBundle.loadString(Config.privacyUrl);
    // Decode JSON and convert to List<PrivacyModel>
    List<dynamic> rawList = jsonDecode(jsonString);
    // Map each item to PrivacyModel
    return rawList.map((e) => PrivacyModel.fromJson(e)).toList();
  }

  Future<List<PrivacyModel>> loadTermsAndConditions() async {
    // Load JSON string from assets
    String jsonString = await rootBundle.loadString(Config.termsConditionUrl);
    // Decode JSON and convert to List<PrivacyModel>
    List<dynamic> rawList = jsonDecode(jsonString);
    // Map each item to PrivacyModel
    return rawList.map((e) => PrivacyModel.fromJson(e)).toList();
  }
}
