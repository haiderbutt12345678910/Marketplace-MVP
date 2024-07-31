import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthRemoteDataSource {
  Future<void> logIn(String email, String password);
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final SharedPreferences prefs;
  final http.Client httpClient;
  AuthRemoteDataSourceImpl({required this.httpClient, required this.prefs});

  @override
  Future<void> logIn(String email, String password) async {
    String tokken = '';

    String loginUrl =
        'https://emarket.deliverers.uk/public/api/login?email=$email&password=$password';

    try {
      final response = await http.post(
        Uri.parse(loginUrl),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        tokken = responseData['data']['token'];
        await prefs.setString('token', tokken);
      } else {
        throw Exception("Error Occured");
      }
    } catch (e) {
      throw Exception("Error occured");
    }
  }
}
