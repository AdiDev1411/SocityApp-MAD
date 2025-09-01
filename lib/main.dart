import 'package:flutter/material.dart';
import 'welcome_screen.dart';
import 'login_screen.dart';
import 'signup_screen.dart';
import 'auth_screen.dart';
import 'home_screen.dart';
import 'create_new_screen.dart';
import 'setup_wings_screen.dart';
import 'dashboard_screen.dart';
import 'Directory/emergency_numbers.dart';
import 'Directory/vehicles_screen.dart';
import 'Interaction/meetings_screen.dart';
import 'Interaction/announcements_screen.dart';
import 'Interaction/notices_screen.dart';
import 'Interaction/events_screen.dart';
import 'Interaction/voting_screen.dart';
import 'Interaction/resources_screen.dart';
import 'Interaction/proposals_screen.dart';
import 'Interaction/suggestions_screen.dart';
import 'Interaction/tasks_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF1976D2);

    return MaterialApp(
      title: 'Role Based App',
      theme: ThemeData(
        primaryColor: primaryColor,
        colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
        scaffoldBackgroundColor: Colors.grey[100],
        fontFamily: 'sans-serif-light',
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: primaryColor, width: 2),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16),
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'sans-serif-condensed',
            ),
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          elevation: 4.0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontFamily: 'sans-serif-condensed',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        cardTheme: CardThemeData(
          elevation: 8.0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/auth': (context) => const AuthScreen(),
        '/home': (context) => const HomeScreen(),
        '/create_new': (context) => const CreateNewScreen(),
        '/setup_wings': (context) => const SetupWingsScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/emergency_numbers': (context) => const EmergencyNumbersScreen(),
        '/vehicles': (context) => const VehiclesScreen(),
        // Add all the new interaction routes
        '/meetings': (context) => const MeetingsScreen(),
        '/announcements': (context) => const AnnouncementsScreen(),
        '/notices': (context) => const NoticesScreen(),
        '/events': (context) => const EventsScreen(),
        '/voting': (context) => const VotingScreen(),
        '/resources': (context) => const ResourcesScreen(),
        '/proposals': (context) => const ProposalsScreen(),
        '/suggestions': (context) => const SuggestionsScreen(),
        '/tasks': (context) => const TasksScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
