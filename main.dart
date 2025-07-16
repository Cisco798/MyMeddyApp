import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/onboarding_screen.dart';
import 'screens/home_screen.dart';
import 'screens/medication_schedule_screen.dart';
import 'screens/health_logs_screen.dart';
import 'screens/appointments_screen.dart';
import 'screens/profile_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final onboardingComplete = prefs.getBool('onboardingComplete') ?? false;
  
  runApp(MyApp(onboardingComplete: onboardingComplete));
}

class MyApp extends StatelessWidget {
  final bool onboardingComplete;
  
  const MyApp({Key? key, required this.onboardingComplete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyMedBuddy',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      initialRoute: onboardingComplete ? '/home' : '/onboarding',
      routes: {
        '/onboarding': (context) => OnboardingScreen(),
        '/home': (context) => HomeScreen(),
        '/medication': (context) => MedicationScheduleScreen(),
        '/logs': (context) => HealthLogsScreen(),
        '/appointments': (context) => AppointmentsScreen(),
        '/profile': (context) => ProfileScreen(),
      },
    );
  }
}