import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/screens/settings/bloc/settings_bloc.dart';
import 'package:frontend/services/settings/settings_service.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> createSettingsProviders() => [
      BlocProvider<SettingsBloc>(
        create: (context) => SettingsBloc(
          context.read<SettingsService>(),
        ),
      ),
    ];
