import 'dart:convert';
import 'package:http/http.dart' as http;

class Info {
  int? id;
  String? email;
  String? name;

  Info({
    required this.id,
    required this.email,
    required this.name,
  });

  factory Info.fromJson(Map<String, dynamic> jsonUsers) {
    return Info(
      id: jsonUsers['id'],
      email: jsonUsers['email'],
      name: jsonUsers['name'],
    );
  }
}

class UserDataRepo {
  Future<List<Info>> getUserData() async {
    String url = "http://192.168.18.18:80/api/getuserdata";
    final response = await http.get(
      Uri.parse(url),
    );
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body) as List;
      return jsonData.map((e) => Info.fromJson(e)).toList();
    } else {
      throw Exception("Failed to get Data");
    }
  }

  Future<String?> editUser(int? userID, String username) async {
    String url = "http://192.168.18.18:80/api/edituser/$userID";
    Map<String, String> headers = {'Content-Type': 'application/json'};
    final response = await http.put(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode({
        'id': userID,
        'name': username,
      }),
    );
    if (response.statusCode == 200) {
      return "Editing Done";
    } else {
      return "No Editing Done";
    }
  }

  Future<String?> deleteUser(int? userID) async {
    String url = "http://192.168.18.18:80/api/deletebyuserid";
    Map<String, String> headers = {'Content-Type': 'application/json'};
    try {
      final response = await http.post(Uri.parse(url),
          headers: headers,
          body: jsonEncode({
            'id': userID,
          }));
      if (response.statusCode == 200) {
        return "User Deleted";
      } else {
        return "Failed to delete user: ${response.statusCode}";
      }
    } catch (e) {
      return "Exception while deleting user: $e";
    }
  }
}
