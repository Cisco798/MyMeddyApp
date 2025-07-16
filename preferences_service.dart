import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static const String _darkModeKey = 'darkMode';
  static const String _notificationsKey = 'notifications';
  static const String _dailyReminderKey = 'dailyReminder';

  Future<bool> getDarkMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_darkModeKey) ?? false;
  }

  Future<void> setDarkMode(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_darkModeKey, value);
  }

  Future<bool> getNotificationsEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_notificationsKey) ?? true;
  }

  Future<void> setNotificationsEnabled(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_notificationsKey, value);
  }

  Future<String> getDailyReminderTime() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_dailyReminderKey) ?? '09:00';
  }

  Future<void> setDailyReminderTime(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_dailyReminderKey, value);
  }
}
