import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/domain/settings_value.dart';
import 'package:frontend/screens/settings/bloc/settings_event.dart';
import 'package:frontend/screens/settings/bloc/settings_state.dart';

import '../../../services/settings/settings_service.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SettingsService _settingsService;

  SettingsBloc(this._settingsService) : super(SettingsInitial()) {
    on<SettingsUrlChanged>(_onUrlChanged);
    on<SettingsSaveRequested>(_onSaveRequested);
  }

  void _onUrlChanged(SettingsUrlChanged event, Emitter<SettingsState> emit) {
    emit(SettingsLoadSuccess(event.url));
  }

  Future<void> _onSaveRequested(SettingsSaveRequested event, Emitter<SettingsState> emit) async {
    emit(SettingsSaveInProgress(state.currentUrl));
    var result = await _settingsService.saveSettings(SettingsValue(backendUrl: state.currentUrl));
    if (result.isSuccess) {
      emit(SettingsSaveSuccess(state.currentUrl));
    } else {
      emit(SettingsSaveFailure(state.currentUrl, result.error!));
    }
  }
}
