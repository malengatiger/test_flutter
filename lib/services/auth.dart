import 'package:busha_app/util/functions.dart';
import 'package:busha_app/util/prefs.dart';
import 'package:firebase_auth/firebase_auth.dart' as m_auth;
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

import '../models/user.dart';
import 'net.dart';

class AuthService {
  static const localUrl = 'http://192.68.186.255:3000/';
  static const remoteUrl = 'TBD';
  final Prefs prefs;
  static const mm ='🔑 🔑 AuthService 🔑';
  AuthService(this.prefs);

  Future<User?> signIn(String email, String password) async {
    var userCred = await m_auth.FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    pp('User is signed in OK? ${userCred.user?.email}, if null, not signed in');
    if (userCred.user == null) {
      return null;
    }
    User mUser = User(
        name: userCred.user!.displayName,
        email: userCred.user!.email,
        uid: userCred.user!.uid);

    await prefs.saveUser(mUser);
    return mUser;
  }

  Future<Response> register(User user) async {
    var token = await _getToken();
    if (token == null) {
      throw Exception('Token not available');
    }
    try {
      String mUrl = localUrl;
      if (!kDebugMode) {
        mUrl = remoteUrl;
      }
      var response =
          await Net.post(url: mUrl, data: user.toJson(), token: token);
      if (response.statusCode == 200 || response.statusCode == 201) {
        pp('$mm registration response 🥬 status is OK!!: 🥬 ${response.statusCode}');
      } else {
        pp('$mm BAD RESPONSE: ${response.statusCode}');
      }
      return response;
    } catch (e) {
      pp('$mm Registration ERROR: $e');
      throw Exception('Registration failed. $e');
    }
  }

  Future<Response> getUserByEmail(String email) async {
    var token = await _getToken();

    try {
      String mUrl = '${localUrl}getUserByEmail';
      if (!kDebugMode) {
        mUrl = '${remoteUrl}getUserByEmail';
      }
      var response =
      await Net.get(mUrl);
      if (response.statusCode == 200 || response.statusCode == 201) {
        pp('$mm User found 🥬 status is OK!!: 🥬 ${response.body}');
      } else {
        pp('$mm BAD RESPONSE: ${response.statusCode}');
      }
      return response;
    } catch (e) {
      pp('$mm getUserByEmail ERROR: $e');
      throw Exception('getUserByEmail failed. $e');
    }
  }
  static Future<bool> isSignedIn() async {
    var user = m_auth.FirebaseAuth.instance.currentUser;
    var res = user == null ? false : true;
    pp('$mm User is signed in: $res');
    return res;
  }

  Future<String?> _getToken() async {
    return m_auth.FirebaseAuth.instance.currentUser?.getIdToken();
  }
}
