abstract class SettingsEvent {}

class LoadSettings extends SettingsEvent {}

class SettingsUrlChanged extends SettingsEvent {
  final String url;

  SettingsUrlChanged(this.url);
}

class SettingsSaveRequested extends SettingsEvent {}
