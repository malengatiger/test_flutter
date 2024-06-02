import 'dart:convert';

import 'package:busha_app/models/user.dart';
import 'package:busha_app/services/auth.dart';
import 'package:busha_app/services/net.dart';
import 'package:busha_app/util/prefs.dart';
import 'package:firebase_auth/firebase_auth.dart' as m_auth;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_test.mocks.dart';


// Generate mocks using:
// flutter pub run build_runner build

@GenerateMocks([
  m_auth.FirebaseAuth,
  m_auth.UserCredential,
  m_auth.User,
  Prefs,
  Net,
  Response
])
void main() {
  late MockFirebaseAuth mockFirebaseAuth;
  late MockUserCredential mockUserCredential;
  late MockUser mockUser;
  late MockPrefs mockPrefs;
  late MockNet mockNet;
  late AuthService authService;

  setUp(() async {
    WidgetsFlutterBinding.ensureInitialized();
    mockFirebaseAuth = MockFirebaseAuth();
    mockUserCredential = MockUserCredential();
    mockUser = MockUser();
    mockPrefs = MockPrefs();
    mockNet = MockNet();
    authService =
        AuthService(mockFirebaseAuth); // Pass the mock FirebaseAuth instance
// Initialize Firebase
    when(authService.signIn('innfo@email.com', 'password'))
        .thenAnswer((_) async =>
        User(name: 'Aubrey', email: 'aubs@gmail.com'));
    // Add this line to stub the saveUser method:
    when(mockPrefs.saveUser(any)).thenAnswer((_) async {});

    await Firebase.initializeApp();

    GetIt.instance.reset();
    GetIt.instance.registerLazySingleton<Prefs>(() => mockPrefs);
    GetIt.instance.registerLazySingleton<Net>(() => mockNet);
  });

  group('AuthService', () {
    // test('signIn signs in user successfully', () async {
    //   // Mock Firebase Auth to return a successful user credential.
    //   when(mockFirebaseAuth.signInWithEmailAndPassword(
    //       email: 'test@email.com', password: 'password'))
    //       .thenAnswer((_) async => mockUserCredential);
    //
    //   when(mockUserCredential.user).thenReturn(mockUser);
    //   when(mockUser.displayName).thenReturn('Test User');
    //   when(mockUser.email).thenReturn('test@email.com');
    //   when(mockUser.uid).thenReturn('test_uid');
    //
    //   when(mockPrefs.saveUser(any)).thenAnswer((_) async {});
    //
    //   // Call the signIn method.
    //   final result = await authService.signIn('test@email.com', 'password');
    //
    //   // Verify that the user is signed in and the user object is returned.
    //   expect(result, isA<User>());
    //   expect(result?.email, 'test@email.com');
    //   expect(result?.uid, 'test_uid');
    //   // Verify that Prefs.saveUser is called.
    //   verify(mockPrefs.saveUser(any));
    // });
    //
    // // ... (Other tests for signIn, signOut, register, etc.)
    //
    // test('getUserByEmail fetches user data', () async {
    //   // Mock Net to return a successful response.
    //   final response = MockResponse();
    //   when(response.statusCode).thenReturn(200);
    //   when(response.body).thenReturn('{"user": "data"}');
    //   when(mockNet.get(any)).thenAnswer((_) async => response);
    //
    //   // Mock _getToken to return a token.
    //   when(mockFirebaseAuth.currentUser).thenReturn(mockUser);
    //   when(mockUser.getIdToken()).thenAnswer((_) async => 'test_token');
    //
    //   // Call the getUserByEmail method.
    //   final result = await authService.getUserByEmail('test@email.com');
    //
    //   // Verify that the result is the expected response.
    //   expect(result, response);
    // });
    //
    // test('isSignedIn returns true when user is signed in', () async {
    //   // Mock FirebaseAuth to return a user.
    //   when(m_auth.FirebaseAuth.instance.currentUser).thenReturn(mockUser);
    //
    //   // Call the isSignedIn method.
    //   final result = await AuthService.isSignedIn();
    //
    //   // Verify that the result is true.
    //   expect(result, true);
    // });
    //
    // test('isSignedIn returns false when user is not signed in', () async {
    //   // Mock FirebaseAuth to return null for currentUser.
    //   when(m_auth.FirebaseAuth.instance.currentUser).thenReturn(null);
    //
    //   // Call the isSignedIn method.
    //   final result = await AuthService.isSignedIn();
    //
    //   // Verify that the result is false.
    //   expect(result, false);
    // });
  });
}
