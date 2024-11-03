import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class AuthService {
  static AuthService instance = AuthService._internal();

  factory AuthService() {
    return instance;
  }

  AuthService._internal();

  final String _baseUrl = 'identitytoolkit.googleapis.com';
  final String _firebaseToken = 'AIzaSyBwrqkeJsZ70NpqmHyGsbAj9Oq3_-hJHiI';

  Future<bool> createUser(String email, String pass) async {
    try {
      final Map<String, dynamic> authData = {'email': email, 'password': pass};

      final url =
          Uri.https(_baseUrl, '/v1/accounts:signUp', {'key': _firebaseToken});

      final resp = await http.post(url, body: json.encode(authData));
      final Map<String, dynamic> decodedREsp = json.decode(resp.body);

      //print(decodedREsp);
      log("$decodedREsp");
      if (decodedREsp.containsKey('idToken')) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> loginWithCredentials(String email, String pass) async {
    try {
      final Map<String, dynamic> datosInicio = {
        'email': email,
        'password': pass
      };

      final url = Uri.https(
          _baseUrl, '/v1/accounts:signInWithPassword', {'key': _firebaseToken});

      final resp = await http.post(url, body: json.encode(datosInicio));
      final Map<String, dynamic> decodedREsp = json.decode(resp.body);

      print(decodedREsp);

      if (decodedREsp['error'] != null) {
        return false;
      } else {
        return true;
      }
    } catch (e) {
      return false;
    }
  }
}
