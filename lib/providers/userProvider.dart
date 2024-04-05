import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../screens/gallaryScreen.dart';
import 'gallaryProvider.dart';

class User {
  String id;
  String name;
  String emaill;
  String token;

  User({
    required this.id,
    required this.emaill,
    required this.name,
    required this.token,
  });
}

class UserProvider with ChangeNotifier {
  late User _user;

  User get user {
    return this._user;
  }

  Future<void> loginUser(
      String email, String password, BuildContext context) async {
    final url = Uri.parse('https://flutter.prominaagency.com/api/auth/login');
    final response = await http.post(url, body: {
      'email': email,
      'password': password,
    });

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      _user = User(
          id: data['user']['id'].toString(),
          emaill: data['user']['email'],
          name: data['user']['name'],
          token: data['token']);
      Provider.of<MyImagesProvider>(context, listen: false)
          .fetchAndSetImages(context,
              Provider.of<UserProvider>(context, listen: false).user.token)
          .then(
              (_) => Navigator.of(context).pushNamed(GallaryScreen.routeName));
      print('iiiiiidddddd = ${_user.id}');
      print("Logged in successfully: ${data['user']['name']}");
    } else {
      print("Failed to login");
    }
  }
}
