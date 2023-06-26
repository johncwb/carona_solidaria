import 'package:carona_solidaria/home/home_screen.dart';
import 'package:carona_solidaria/login/login_screen.dart';
import 'package:carona_solidaria/provider/google_sign_in.dart';
import 'package:carona_solidaria/services/auth_service.dart';
import 'package:carona_solidaria/splash/splash_screen.dart';
import 'package:carona_solidaria/utils/no_connection.dart';
import 'package:carona_solidaria/widgets/auth_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';

import 'landing/landing_screen.dart';
import 'register/register_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final hasConnection = await InternetConnectionChecker().hasConnection;
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: ((context) => AuthServices()),
        ),
        ChangeNotifierProvider(
          create: (context) => ValueNotifier(hasConnection),
        ),
      ],
      child: const MyApp(),
    ),
    // ConnectionNotifier(
    //   notifier: ValueNotifier(hasConnection),
    //   child: const MyApp(),
    // ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Carona Solidária',
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          '/home': (context) => const HomeScreen(
                isUser: false,
                isMotorista: true,
              ),
          '/noConnection': (context) => const NoConnection(),
          '/authCheck': (context) => const AuthCheck(),
          '/landing': (context) => const LandingScreen(),
          '/login': (context) => const LoginScreen(),
          '/register': (context) => const RegisterScreen(),
        },
      ),
    );
  }
}
