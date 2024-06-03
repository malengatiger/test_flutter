import 'dart:convert';

import 'package:busha_app/util/functions.dart';
import 'package:busha_app/util/prefs.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:http/http.dart';
import 'package:welltested_annotation/welltested_annotation.dart';

import '../models/user.dart';
import 'net.dart';

@Welltested()
class AuthService {
  static const localUrl = 'http://192.168.86.230:8080/';
  static const remoteUrl = 'https://busha-nest-1-ajtawuiiiq-ew.a.run.app/';
  static const mm = '🔑🔑🔑🔑🔑🔑 AuthService 🔑';

  final auth.FirebaseAuth firebaseAuth;
  final Net net;
  final Prefs prefs;
  AuthService(this.firebaseAuth, this.net, this.prefs);

  Future<User?> signIn(String email, String password) async {
    try {
      var userCred = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      pp('$mm User is signed in OK? ${userCred.user?.email}, if null, not signed in');
      if (userCred.user == null) {
        return null;
      }
      User mUser = User(
          name: userCred.user!.displayName,
          email: userCred.user!.email,
          uid: userCred.user!.uid);
      try {
        prefs.saveUser(mUser);
        pp('$mm we have cached ${mUser.toJson()}');

      } catch (e,s) {
        pp('$e $s');
      }

      // await prefs.saveUser(mUser);
      return mUser;
    } catch (e, s) {
      pp('$e\n$s');
      throw Exception('SignIn failed. \n\n$e\n\nPlease try again.');
    }
  }

  Future signOut() async {
    await firebaseAuth.signOut();
  }

  Future<bool> register(User user) async {
    pp('$mm register: 🥬 ${user.toJson()}');

    Response? response;
    // var mFirestore = fs.FirebaseFirestore.instance;
    try {
      response = await net.post(
          path: 'on-boarding/registerUser', data: user.toJson(), token: '');

      if (response.statusCode == 200 || response.statusCode == 201) {
        pp('$mm registration response 🥬 status is being checked!!: '
            '🥬 ${response.statusCode} ==> \n🥬🥬🥬 response.body ${response.body}');
        var failResp = jsonDecode(response.body)['response'];
        if (failResp != null) {
          pp('$mm we are failing at something??? $failResp');
          return false;
        } else {
          try {
            var user = User.fromJson(jsonDecode(response.body));
            prefs.saveUser(user);
            pp('$mm we have cached ${user.toJson()}');

          } catch (e,s) {
            pp('$e $s');
          }
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
      var response = await net.get('getUserByEmail');
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

   Future<bool> isSignedIn() async {
    var user = auth.FirebaseAuth.instance.currentUser;
    var res = user == null ? false : true;
    pp('$mm User is signed in: $res');
    return res;
  }

  Future<String?> _getToken() async {
    return auth.FirebaseAuth.instance.currentUser?.getIdToken();
  }
}
