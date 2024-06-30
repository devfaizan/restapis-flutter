import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:withlaravel/provider/bottomnavbar.dart';
import 'package:withlaravel/screens/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BottomNavProvider(),
      child: MaterialApp(
        title: "withlaravelhttp",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          primaryColor: const Color.fromARGB(255, 251, 102, 91),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(217, 221, 221, 221),
            ),
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              backgroundColor: const Color.fromARGB(217, 221, 221, 221),
            ),
          ),
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
              side: const BorderSide(
                color: Color.fromARGB(217, 179, 179, 179),
              ),
            ),
          ),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
