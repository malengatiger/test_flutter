import 'dart:convert';

import 'package:busha_app/models/user.dart';
import 'package:busha_app/services/auth.dart';
import 'package:busha_app/services/net.dart';
import 'package:busha_app/util/prefs.dart';
import 'package:firebase_auth/firebase_auth.dart' as m_auth;
import 'package:firebase_core/firebase_core.dart' as fb;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';

import 'auth_test.mocks.dart';


// Generate mocks using:
// flutter pub run build_runner build

@GenerateMocks([
  m_auth.FirebaseAuth,
  m_auth.UserCredential,
  m_auth.User,
  Prefs,
  Net,
  Response,
  fb.Firebase,

])
typedef Callback = void Function(MethodCall call);

void setupFirebaseAuthMocks([Callback? customHandlers]) {
  TestWidgetsFlutterBinding.ensureInitialized();

  setupFirebaseCoreMocks();
}

Future<T> neverEndingFuture<T>() async {
  while (true) {
    await Future.delayed(const Duration(minutes: 5));
  }
}
void main() {
  late MockFirebaseAuth mockFirebaseAuth;
  late MockUserCredential mockUserCredential;
  late MockUser mockUser;
  late MockPrefs mockPrefs;
  late MockNet mockNet;
  late AuthService authService;
  late Firebase mockFirebase;

  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    mockUserCredential = MockUserCredential();
    mockUser = MockUser();
    mockPrefs = MockPrefs();
    mockNet = MockNet();
    authService = AuthService();
    mockFirebase = MockFirebase();

    GetIt.instance.reset();
    GetIt.instance.registerLazySingleton<Prefs>(() => mockPrefs);
    GetIt.instance.registerLazySingleton<Net>(() => mockNet);

  });

  group('AuthService', () {
    test('🥬🥬 signIn signs in user successfully', () async {
      // Mock Firebase Auth to return a successful user credential.

      when(mockFirebaseAuth.signInWithEmailAndPassword(
              email: 'test@email.com', password: 'password'))
          .thenAnswer((_) async => mockUserCredential);
      when(mockUserCredential.user).thenReturn(mockUser);
      when(mockUser.displayName).thenReturn('Test User');
      when(mockUser.email).thenReturn('test@email.com');
      when(mockUser.uid).thenReturn('test_uid');

      // Call the signIn method.
      final result = await authService.signIn('test@email.com', 'password');

      // Verify that the user is signed in and the user object is returned.
      expect(result, isA<User>());
      expect(result?.email, 'test@email.com');
      expect(result?.uid, 'test_uid');

      // Verify that Prefs.saveUser is called.
      verify(mockPrefs.saveUser(any));
    });

    test('signIn returns null when sign in fails', () async {
      // Mock Firebase Auth to return null for user credential.
      when(mockFirebaseAuth.signInWithEmailAndPassword(
              email: 'test@email.com', password: 'password'))
          .thenAnswer((_) async => mockUserCredential);
      when(mockUserCredential.user).thenReturn(null);

      // Call the signIn method.
      final result = await authService.signIn('test@email.com', 'password');

      // Verify that null is returned.
      expect(result, isNull);
    });

    test('signOut signs out user', () async {
      // Call the signOut method.
      await authService.signOut();
      // Verify that FirebaseAuth.signOut is called.
      verify(mockFirebaseAuth.signOut());
    });

    test('register registers user successfully', () async {
      // Mock Net to return a successful response.
      final response = MockResponse();
      when(response.statusCode).thenReturn(200);
      when(response.body).thenReturn(jsonEncode(
          {'name': 'Test User', 'email': 'test@email.com', 'uid': 'test_uid'}));
      when(mockNet.post(
              path: anyNamed('path'),
              data: anyNamed('data'),
              token: anyNamed('token')))
          .thenAnswer((_) async => response);

      // Call the register method.
      final result = await authService.register(
          User(name: 'Test User', email: 'test@email.com', uid: 'test_uid'));

      // Verify that the registration is successful.
      expect(result, true);

      // Verify that Prefs.saveUser is called.
      verify(mockPrefs.saveUser(any));
    });
  });
}
