import 'dart:convert';

import 'package:busha_app/util/functions.dart';
import 'package:busha_app/util/prefs.dart';
import 'package:firebase_auth/firebase_auth.dart' as m_auth;
import 'package:cloud_firestore/cloud_firestore.dart' as fs;
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

import '../models/user.dart';
import 'net.dart';

//https://busha-nest-1-ajtawuiiiq-ew.a.run.app
class AuthService {
  static const localUrl = 'http://192.168.86.230:8080/';
  static const remoteUrl = 'https://busha-nest-1-ajtawuiiiq-ew.a.run.app/';
  final Prefs prefs;
  static const mm = '🔑 🔑 AuthService 🔑';

  AuthService(this.prefs);

  Future<User?> signIn(String email, String password) async {
    try {
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
    } catch (e, s) {
      pp('$e\n$s');
      throw Exception('SignIn failed. \n\n$e\n\nPlease try again.');
    }
  }

  static Future signOut() async {
    await m_auth.FirebaseAuth.instance.signOut();
  }

  Future<bool> register(User user) async {
    pp('$mm register: 🥬 ${user.toJson()}');

    Response? response;
    var mFirestore = fs.FirebaseFirestore.instance;
    //response.body {"response":{"message":"Error: The email address is already in use by another account.","error":"Unauthorized","statusCode":401},"status":401,"options":{},"message":"Error: The email address is already in use by another account.","name":"UnauthorizedException"}
    try {
      response = await Net.post(
          path: 'on-boarding/registerUser', data: user.toJson(), token: '');

      if (response.statusCode == 200 || response.statusCode == 201) {
        pp('$mm registration response 🥬 status is being checked!!: '
            '🥬 ${response.statusCode} ==> \n🥬🥬🥬 response.body ${response.body}');
        var failResp = jsonDecode(response.body)['response'];
        if (failResp != null) {
          pp('$mm we are failing at something??? $failResp');
          return false;
        } else {
          var user = User.fromJson(jsonDecode(response.body));
          prefs.saveUser(user);
          return true;
        }

      }
      if (response.statusCode == 201) {
        pp('$mm registration response 🍐 status is ehhhhh!: '
            '🍐 ${response.statusCode} ==> \n 🍐🍐🍐 response.body ${response.body}');
        return false;

      }
      if (response.statusCode > 201) {
        pp('$mm registration response 😡😡 status is not OK!!: '
            '😡 ${response.statusCode} ==> \n 😡😡😡 response.body ${response.body}');
        return false;
      }

    } catch (e, s) {
      pp('$mm Registration ERROR: $e -$s');
      if (response != null) {
        if (response.statusCode == 200 || response.statusCode == 201) {
          throw Exception('$e');
        }
      }
      throw Exception('Registration failed. \n\n$e\n\nPlease try again!');
    }
    return false;
  }

  Future<Response> getUserByEmail(String email) async {
    var token = await _getToken();

    try {
      var response = await Net.get('getUserByEmail');
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
