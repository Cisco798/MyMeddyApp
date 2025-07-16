import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/preferences_service.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late bool _darkMode;
  late bool _notifications;
  late String _dailyReminderTime;
  final _prefsService = PreferencesService();

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    _darkMode = await _prefsService.getDarkMode();
    _notifications = await _prefsService.getNotificationsEnabled();
    _dailyReminderTime = await _prefsService.getDailyReminderTime();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: ListView(
        children: [
          SwitchListTile(
            title: Text('Dark Mode'),
            value: _darkMode,
            onChanged: (value) async {
              await _prefsService.setDarkMode(value);
              setState(() => _darkMode = value);
            },
          ),
          SwitchListTile(
            title: Text('Enable Notifications'),
            value: _notifications,
            onChanged: (value) async {
              await _prefsService.setNotificationsEnabled(value);
              setState(() => _notifications = value);
            },
          ),
          ListTile(
            title: Text('Daily Reminder Time'),
            subtitle: Text(_dailyReminderTime),
            onTap: () async {
              final time = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );
              if (time != null) {
                final timeStr = '${time.hour}:${time.minute}';
                await _prefsService.setDailyReminderTime(timeStr);
                setState(() => _dailyReminderTime = timeStr);
              }
            },
          ),
        ],
      ),
    );
  }
}