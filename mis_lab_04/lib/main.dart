import 'package:flutter/material.dart';
import 'package:mis_lab_04/screens/event_details.dart';
import 'package:mis_lab_04/screens/events_calendar.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mis_lab_04/screens/events_map.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 04',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      localizationsDelegates: const [
        ...GlobalMaterialLocalizations.delegates,
        GlobalWidgetsLocalizations.delegate,
        SfGlobalLocalizations.delegate
      ],
      supportedLocales: const [
        Locale('mk'),
      ],
      locale: const Locale('mk'),
      initialRoute: "/calendar",
      routes: {
        "/calendar": (context) => const EventsCalendar(),
        "/map": (context) => const EventsMap(),
        "/details": (context) => const EventDetails(),
      },
    );
  }
}
