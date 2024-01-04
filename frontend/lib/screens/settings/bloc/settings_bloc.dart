import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/domain/settings_value.dart';
import 'package:frontend/screens/settings/bloc/settings_event.dart';
import 'package:frontend/screens/settings/bloc/settings_state.dart';

import '../../../services/settings/settings_service.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SettingsService _settingsService;

  SettingsBloc(this._settingsService) : super(SettingsInitial()) {
    on<LoadSettings>(_onLoadSettings);
    on<SettingsUrlChanged>(_onUrlChanged);
    on<SettingsSaveRequested>(_onSaveRequested);
  }

  Future<void> _onLoadSettings(LoadSettings event, Emitter<SettingsState> emit) async {
    emit(SettingsLoadInProgress(''));
    var result = await _settingsService.loadSettings();

    print(result.value?.backendUrl);

    result
        .onFailure((error) => emit(SettingsLoadFailure('', error)))
        .onSuccess((settings) => emit(SettingsLoadSuccess(settings?.backendUrl ?? '')));
  }

  void _onUrlChanged(SettingsUrlChanged event, Emitter<SettingsState> emit) {
    emit(SettingsLoadSuccess(event.url));
  }

  Future<void> _onSaveRequested(SettingsSaveRequested event, Emitter<SettingsState> emit) async {
    emit(SettingsSaveInProgress(state.currentUrl));
    var result = await _settingsService.saveSettings(SettingsValue(backendUrl: state.currentUrl));

    result
        .onFailure((error) => emit(SettingsSaveFailure(state.currentUrl, error)))
        .onSuccess((_) => emit(SettingsSaveSuccess(state.currentUrl)));
  }
}
