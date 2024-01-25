import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:frontend/components/custom_button.dart';
import 'package:frontend/components/custom_progress_indicator.dart';
import 'package:frontend/components/form_textfield.dart';
import 'package:frontend/screens/settings/bloc/settings_bloc.dart';
import 'package:frontend/screens/settings/bloc/settings_event.dart';
import 'package:frontend/screens/settings/bloc/settings_state.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool themeSwitch = false;
  bool notificationSwitch = false;

  @override
  Widget build(BuildContext context) {
    final settingsBloc = BlocProvider.of<SettingsBloc>(context);
    settingsBloc.add(LoadSettings());

    final textController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(
            fontFamily: 'JejuGothic',
            fontSize: 20.0,
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
              Future.delayed(const Duration(milliseconds: 200), () {
                Navigator.pop(context);
              });
            } else {
              Navigator.pop(context);
            }
          },
        ),
      ),
      body: BlocConsumer<SettingsBloc, SettingsState>(
        listener: (context, state) {
          if (state is SettingsSaveSuccess) {
            _showSettingsSavedDialog(context);
          } else if (state is SettingsSaveFailure) {
            SnackBar(content: Text('Failed to save settings: ${state.error}'));
          } else if (state is SettingsLoadFailure) {
            SnackBar(content: Text('Failed to load settings: ${state.error}'));
          } else if (state is SettingsLoadSuccess) {
            textController.text = state.currentUrl;
          }
        },
        builder: (context, state) => Container(
          color: const Color(0xFF9A8C98),
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFFFF).withOpacity(0.24),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Light mode / dark mode',
                                  style: TextStyle(
                                    fontFamily: 'JejuGothic',
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                FlutterSwitch(
                                  value: themeSwitch,
                                  onToggle: (value) {
                                    setState(
                                      () {
                                        themeSwitch = value;
                                        print(themeSwitch);
                                      },
                                    );
                                  },
                                  inactiveColor: const Color(0xFF4A4E69),
                                  activeColor: Colors.green,
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color: const Color(0xFF4A4E69).withOpacity(0.35),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Notification',
                                  style: TextStyle(
                                    fontFamily: 'JejuGothic',
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                FlutterSwitch(
                                  value: notificationSwitch,
                                  onToggle: (value) {
                                    setState(
                                      () {
                                        notificationSwitch = value;
                                        print(notificationSwitch);
                                      },
                                    );
                                  },
                                  inactiveColor: const Color(0xFF4A4E69),
                                  activeColor: Colors.green,
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color: const Color(0xFF4A4E69).withOpacity(0.35),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: FormTextfieldComponent(
                              hintText: 'Enter backend URL',
                              obscureText: false,
                              onChanged: (url) => settingsBloc.add(
                                SettingsUrlChanged(url),
                              ),
                              controller: textController,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  CustomButtonComponent(
                    text: 'Save settings',
                    width: 192,
                    height: 48,
                    onPressed: () => _showSaveConfirmationDialog(context, settingsBloc),
                  ),
                  if (state is SettingsSaveInProgress)
                    const CustomProgressIndicator(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showSettingsSavedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Success'),
        content: const Text('Settings saved successfully.'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
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
