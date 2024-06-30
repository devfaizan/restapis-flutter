import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:withlaravel/components/textstyless.dart';
import 'package:withlaravel/components/validation.dart';
import 'package:http/http.dart' as http;

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  @override
  Widget build(BuildContext context) {
    final key = GlobalKey<FormState>();
    TextEditingController emailController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    String email = "", name = "", password = "";

    Future createUser() async {
      if (key.currentState!.validate()) {
        setState(() {});
        // setState(() {
        //   showSpinner = false;
        //   print("Chuchu");
        //   print(emailController.text);
        //   print(nameController.text);
        //   print(passwordController.text);
        // });
        String url = "http://192.168.18.18:80/api/users";
        Map<String, String> headers = {'Content-Type': 'application/json'};
        try {
          final response = await http.post(
            Uri.parse(url),
            headers: headers,
            body: jsonEncode(
              {
                'email': email,
                'name': name,
                'password': password,
              },
            ),
          );
          if (response.statusCode == 200) {
            setState(() {});
          } else {
            setState(() {});
          }
        } catch (e) {
          // toastMessage(e.toString(), Colors.amber);
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Form Page"),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Center(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 5),
              child: Column(
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: Text(
                      "Submit A Form Using RestAPI",
                      style: TextStyles.thickheading,
                    ),
                  ),
                  Form(
                    key: key,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 15,
                          ),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Enter Your Email Address",
                            ),
                            controller: emailController,
                            onChanged: (String value) {
                              email = value;
                            },
                            validator: validateEmail,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 15,
                          ),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Enter Your Name",
                            ),
                            controller: nameController,
                            onChanged: (String value) {
                              name = value;
                            },
                            validator: validateText,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 15,
                          ),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Enter Your Password",
                            ),
                            controller: passwordController,
                            onChanged: (String value) {
                              password = value;
                            },
                            validator: validatePassword,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: OutlinedButton(
                            onPressed: () {
                              createUser();
                            },
                            child: Text(
                              "Submit Form",
                              style: TextStyles.buttonNormal(
                                Theme.of(context),
                              ),
                            ),
                          ),
                        ),
                      ],
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
}
