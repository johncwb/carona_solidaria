import 'package:carona_solidaria/home/home_screen.dart';
import 'package:carona_solidaria/splash/splash_screen.dart';
import 'package:carona_solidaria/utils/connection_checker/connection_checker.dart';
import 'package:carona_solidaria/utils/no_connection.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

void main() async {
  final hasConnection = await InternetConnectionChecker().hasConnection;
  runApp(
    ConnectionNotifier(
      notifier: ValueNotifier(hasConnection),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Carona Solidária',
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => const HomeScreen(),
        '/noConnection': (context) => const NoConnection(),
      },
    );
  }
}
