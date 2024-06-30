// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:withlaravel/components/iconsnbutton.dart';
import 'package:withlaravel/components/textstyless.dart';
import 'package:withlaravel/components/validation.dart';
import 'package:withlaravel/models/userdata.dart';
import 'package:shimmer/shimmer.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class UserData extends StatefulWidget {
  const UserData({Key? key}) : super(key: key);

  @override
  State<UserData> createState() => _UserDataState();
}

class _UserDataState extends State<UserData> {
  final userDataRepo = UserDataRepo();
  late Future<List<Info>> _userDataFuture;

  final _key = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  String name = "";

  @override
  void initState() {
    super.initState();
    _userDataFuture = fetchUserDataFromRepo();
  }

  Future<List<Info>> fetchUserDataFromRepo() async {
    try {
      final data = await userDataRepo.getUserData();
      return data;
    } catch (e) {
      return Future.error('Failed to fetch data');
    }
  }

  Future<void> fetchAgain() async {
    setState(() {
      _userDataFuture = fetchUserDataFromRepo();
    });
  }

  // Future createUser() async {
  //   if (_key.currentState!.validate()) {
  //     print("Chuchu");
  //     print(nameController.text);
  //   }
  // }

  Future<String?> editUser(String userID, String username) async {
    String url = "http://192.168.18.18:80/api/edituser/$userID";
    Map<String, String> headers = {'Content-Type': 'application/json'};
    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(
        {
          'id': userID,
          'name': username,
        },
      ),
    );
    if (response.statusCode == 200) {
      return "Editing Done";
    } else {
      return "No Editing Done";
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeColorPrimary = Theme.of(context).primaryColor;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Data"),
        centerTitle: true,
        backgroundColor: themeColorPrimary,
      ),
      body: FutureBuilder<List<Info>>(
        future: _userDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _buildShimmerList();
          } else if (snapshot.hasError) {
            return Center(
              // child: Text('Error: ${snapshot.error}'),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("images/cat1.png"),
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: OutlinedButton(
                      onPressed: () {
                        fetchAgain();
                      },
                      child: Text(
                        "Try Again",
                        style: TextStyles.buttonNormal(
                          Theme.of(context),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            final actualData = snapshot.data!;
            return ListView.builder(
              itemCount: actualData.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Text(
                    actualData[index].id.toString(),
                  ),
                  title: Text(
                    actualData[index].email ?? 'No Email',
                  ),
                  subtitle: Text(
                    actualData[index].name ?? 'No Name',
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      IconButtons(
                        compIcon: Icons.edit,
                        dothis: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  scrollable: true,
                                  title: const Text('Login'),
                                  content: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: miniForm(),
                                  ),
                                  actions: [
                                    ElevatedButton(
                                      child: const Text("Submit"),
                                      onPressed: () async {
                                        if (_key.currentState!.validate()) {
                                          // setState(() {});
                                          editUser(
                                              actualData[index].id.toString(),
                                              nameController.text);
                                          await fetchAgain();
                                          Navigator.of(context).pop();
                                        }
                                      },
                                    ),
                                    ElevatedButton(
                                      child: const Text("Cancel"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              });
                        },
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      IconButtons(
                        compIcon: Icons.delete,
                        compColor: themeColorPrimary,
                        dothis: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title:
                                    Text("Delete ${actualData[index].name}!"),
                                content: Text(
                                  "Do you want to delete ${actualData[index].name}?",
                                  style: TextStyles.highlighter,
                                ),
                                actions: [
                                  ElevatedButton(
                                    child: const Text("Cancel"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: themeColorPrimary,
                                    ),
                                    onPressed: () async {
                                      userDataRepo
                                          .deleteUser(actualData[index].id!);
                                      await fetchAgain();
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("Delete"),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  Widget _buildShimmerList() {
    return Shimmer.fromColors(
      baseColor: Colors.red.shade100,
      highlightColor: Colors.red.shade200,
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.white,
              radius: 30,
            ),
            title: Container(
              height: 20,
              color: Colors.red.shade200,
            ),
            subtitle: Container(
              height: 16,
              color: Colors.red.shade200,
            ),
          );
        },
      ),
    );
  }

  Widget miniForm() {
    return Form(
      key: _key,
      child: Column(
        children: [
          TextFormField(
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
        ],
      ),
    );
  }
}
