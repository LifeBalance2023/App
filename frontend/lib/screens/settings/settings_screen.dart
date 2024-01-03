import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/screens/settings/bloc/settings_bloc.dart';
import 'package:frontend/screens/settings/bloc/settings_event.dart';
import 'package:frontend/screens/settings/bloc/settings_state.dart';


class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsBloc = BlocProvider.of<SettingsBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: BlocListener<SettingsBloc, SettingsState>(
        listener: (context, state) {
          if (state is SettingsSaveSuccess) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Success'),
                content: const Text('Settings saved successfully.'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                      // Restart the application logic here
                    },
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          } else if (state is SettingsSaveFailure) {
            // Handle failure state
          }
        },
        child: BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TextField(
                    onChanged: (url) => settingsBloc.add(SettingsUrlChanged(url)),
                    decoration: const InputDecoration(
                      labelText: 'Backend URL',
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => _showSaveConfirmationDialog(context, settingsBloc),
                    child: const Text('Save Settings'),
                  ),
                  if (state is SettingsSaveInProgress) const CircularProgressIndicator(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _showSaveConfirmationDialog(BuildContext context, SettingsBloc settingsBloc) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm'),
        content: const Text('Are you sure you want to save these settings?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
              settingsBloc.add(SettingsSaveRequested());
            },
            child: const Text('Yes'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(), // Close the dialog
            child: const Text('No'),
          ),
        ],
      ),
    );
  }
}
