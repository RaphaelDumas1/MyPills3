import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mypills3/screens/welcome_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  Intl.defaultLocale = 'fr';
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const WelcomePage(title: 'Flutter Demo Home Page'),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('fr'), 
      ],
    );
  }
}


