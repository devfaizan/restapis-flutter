import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:withlaravel/screens/homepage.dart';
import 'package:withlaravel/screens/mainerror.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isVisible = false;
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 1),
      () async {
        setState(() {
          _isVisible = true;
        });
        Future.delayed(
          const Duration(seconds: 1),
          _navigateBasedOnConnection,
        );
      },
    );
  }

  Future<void> _navigateBasedOnConnection() async {
    bool isConnected = await checkConnection();
    if (!isConnected) {
      // ignore: use_build_context_synchronously
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const ErrorScreen(),
        ),
        (Route<dynamic> route) => false,
      );
    } else {
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    }
  }

  Future<bool> checkConnection() async {
    String url = "http://192.168.18.18:80/api/checkconnection";
    try {
      final response = await http.get(
        Uri.parse(url),
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedOpacity(
          opacity: _isVisible ? 1.0 : 0.0,
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOut,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("images/splash.png"),
              const Text("Rest APIs Done Right"),
            ],
          ),
        ),
      ),
    );
  }
}
