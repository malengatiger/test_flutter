import 'dart:convert';

import 'package:busha_app/util/functions.dart';
import 'package:busha_app/util/prefs.dart';
import 'package:firebase_auth/firebase_auth.dart' as m_auth;
import 'package:cloud_firestore/cloud_firestore.dart' as fs;
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

import '../models/user.dart';
import 'net.dart';

class AuthService {
  static const localUrl = 'http://192.168.86.230:3000/';
  static const remoteUrl = 'TBD';
  final Prefs prefs;
  static const mm = '🔑 🔑 AuthService 🔑';

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
    pp('$mm register: 🥬 ${user.toJson()}');

    var mFirestore = fs.FirebaseFirestore.instance;
    try {
      String mUrl = '${localUrl}on-boarding/registerUser';
      if (!kDebugMode) {
        mUrl = '${remoteUrl}on-boarding/registerUser';
      }
      var response = await Net.post(url: mUrl, data: user.toJson(),
          token: '');
      if (response.statusCode == 200 || response.statusCode == 201) {
        pp('$mm registration response 🥬 status is OK!!: '
            '🥬 ${response.statusCode} ==> ${response.body}');
        var user = User.fromJson(jsonDecode(response.body));
        prefs.saveUser(user);
        var mRes = await signIn(user.email!, user.password!);
        if (mRes != null) {
          pp('$mm user should be signed in: ${mRes.toJson()}');
        }
        // var res = await mFirestore
        //     .collection('users').add(user.toJson());
        // pp('$mm Firestore add user result: $res');

      } else {
        pp('$mm BAD RESPONSE: ${response.statusCode}');
        throw Exception(
            'Registration failed. BAD RESPONSE. ${response.statusCode} - ${response.body}');
      }
      return response;
    } catch (e, s) {
      pp('$mm Registration ERROR: $e -$s');
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
      var response = await Net.get(mUrl);
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
