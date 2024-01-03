import 'package:frontend/cache/settings_cache.dart';
import 'package:frontend/domain/result.dart';
import 'package:frontend/domain/settings_value.dart';

class SettingsService {
  final SettingsCache _cache;

  SettingsService(this._cache);

  Future<Result<void>> saveSettings(SettingsValue settings) async => _cache.saveSettings(settings);

  Future<Result<SettingsValue?>> loadSettings() async => _cache.loadSettings();
}
