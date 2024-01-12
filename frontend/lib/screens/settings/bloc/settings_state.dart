import 'package:frontend/domain/result.dart';

abstract class SettingsState {
  final String currentUrl;

  SettingsState(this.currentUrl);
}

class SettingsInitial extends SettingsState {
  SettingsInitial() : super('');
}

class SettingsLoadInProgress extends SettingsState {
  SettingsLoadInProgress(String currentUrl) : super(currentUrl);
}

class SettingsLoadSuccess extends SettingsState {
  SettingsLoadSuccess(String currentUrl) : super(currentUrl);
}

class SettingsLoadFailure extends SettingsState {
  final ResultError error;

  SettingsLoadFailure(String currentUrl, this.error) : super(currentUrl);
}

class SettingsSaveInProgress extends SettingsState {
  SettingsSaveInProgress(String currentUrl) : super(currentUrl);
}

class SettingsSaveSuccess extends SettingsState {
  SettingsSaveSuccess(String currentUrl) : super(currentUrl);
}

class SettingsSaveFailure extends SettingsState {
  final ResultError error;

  SettingsSaveFailure(String currentUrl, this.error) : super(currentUrl);
}