import 'package:flutter/material.dart';
import 'package:kurakani/providers/auth_provider.dart';
import 'package:kurakani/screens/home_page.dart';
import 'package:kurakani/screens/login_page.dart';
import 'package:kurakani/screens/registration_page.dart';
import 'package:kurakani/screens/splash_screen.dart';
import 'package:provider/provider.dart';

import '../services/navigation_service.dart';

void main() {
  runApp(SplashScreen(
    key: UniqueKey(),
    onInitializationComplete: () {
      runApp(const MainApp());
    },
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(create:(context)=> AuthProvider() )
      ],
      child: MaterialApp(
        title: "Kurakani",
        theme: ThemeData(
            dialogBackgroundColor: const Color.fromRGBO(36, 35, 49, 1.0),
            scaffoldBackgroundColor: const Color.fromRGBO(36, 35, 49, 1.0),
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              backgroundColor: Color.fromRGBO(30, 29, 37, 1.0),
            )),
        navigatorKey: NavigationService.navigationKey,
        initialRoute: '/login',
        routes: {
          '/login': (context) =>const  LoginPage(),
          '/home': (context)=> const HomePage(),
          '/register': (context)=> const RegistrationPage()
        },
      ),
    );
  }
}
