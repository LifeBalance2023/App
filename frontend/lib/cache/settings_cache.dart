import 'dart:convert';

import 'package:frontend/domain/result.dart';
import 'package:frontend/domain/settings_value.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsCache {
  final String _settingsKey = 'settings';

  Future<Result<void>> saveSettings(SettingsValue settings) async {
    return Result.runVoidCatchingAsync(() async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String settingsJson = _toJson(settings);
      await prefs.setString(_settingsKey, settingsJson);
    });
  }

  Future<Result<SettingsValue?>> loadSettings() async {
    return Result.runCatchingAsync(() async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? settingsJson = prefs.getString(_settingsKey);
      if (settingsJson != null) {
        return _fromJson(settingsJson);
      }
      return null;
    });
  }

  String _toJson(SettingsValue settings) {
    return jsonEncode({'backendUrl': settings.backendUrl});
  }

  SettingsValue _fromJson(String jsonString) {
    Map<String, dynamic> json = jsonDecode(jsonString);
    return SettingsValue(backendUrl: json['backendUrl']);
  }
}
