import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:withlaravel/components/textstyless.dart';
import 'package:http/http.dart' as http;
import 'package:withlaravel/screens/homepage.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("images/cat1.png"),
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      // Try again button pressed
                      _tryAgain(context);
                    },
                    child: Text(
                      "Try Again",
                      style: TextStyles.buttonNormal(
                        Theme.of(context),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  OutlinedButton(
                    onPressed: () {
                      // Exit app button pressed
                      _exitApp(context);
                    },
                    child: Text(
                      "Exit App",
                      style: TextStyles.buttonNormal(
                        Theme.of(context),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _tryAgain(BuildContext context) {
    // Check for connection again
    checkConnection().then((isConnected) {
      if (isConnected) {
        // If connected, navigate to home screen
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
            (Route<dynamic> route) => false);
      } else {
        // If still not connected, show error message again
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Unable to connect to the server.'),
          ),
        );
      }
    });
  }

  void _exitApp(BuildContext context) {
    // Close the app
    SystemNavigator.pop();
    exit(0);
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
}
