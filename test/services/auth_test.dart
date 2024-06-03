import 'dart:convert';

import 'package:busha_app/models/user.dart';
import 'package:busha_app/services/auth.dart';
import 'package:busha_app/services/net.dart';
import 'package:busha_app/util/prefs.dart';
import 'package:firebase_auth/firebase_auth.dart' as m_auth;
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_test.mocks.dart';


// Generate mocks using:
// flutter pub run build_runner build

@GenerateMocks([m_auth.FirebaseAuth, m_auth.UserCredential, m_auth.User, Prefs, Net])
void main() {
  late MockFirebaseAuth mockFirebaseAuth;
  late MockUserCredential mockUserCredential;
  late MockUser mockUser;
  late MockPrefs mockPrefs;
  late AuthService authService;
  late Net mockNet;

  setUp(() {
    // Initialize mocks
    mockFirebaseAuth = MockFirebaseAuth();
    mockUserCredential = MockUserCredential();
    mockUser = MockUser();
    mockPrefs = MockPrefs();
    mockNet = MockNet();
    // Create AuthService instance with mock FirebaseAuth
    authService = AuthService(mockFirebaseAuth, mockNet, mockPrefs);
    when(mockPrefs.saveUser(any)).thenAnswer((_) async => null);

    // GetIt.instance.reset();
    // GetIt.instance.registerLazySingleton<Net>(() => mockNet);

  });

  group('AuthService', () {
    test('signs in user successfully', () async {
      when(mockFirebaseAuth.signInWithEmailAndPassword(email: anyNamed('email'), password: anyNamed('password')))
          .thenAnswer((_) async => mockUserCredential);
      // Configure mockUser to simulate successful authentication
      when(mockUserCredential.user).thenReturn(mockUser);
      when(mockUser.displayName).thenReturn('Test User');
      when(mockUser.email).thenReturn('test@email.com');
      when(mockUser.uid).thenReturn('test_uid');

      // Call the signIn method
      final result = await authService.signIn('test@email.com', 'password');

      // Verify the result
      expect(result, isA<User>()); // Check if a User object is returned
      expect(result?.email, 'test@email.com'); // Check email
      expect(result?.uid, 'test_uid'); // Check uid

    });

    test('register user successfully', () async {
      // Stub the mockNet.post method with matching arguments
      var user = User(name: 'John',
          email: 'john@gmail.com', password: 'pass778');
      when(mockNet.post(
          path: 'on-boarding/registerUser',
          data: user.toJson(),
          token: '' // Or provide the specific token if known
      )).thenAnswer((_) async => Response(jsonEncode(user.toJson()), 200));

      when(mockPrefs.saveUser(user)).thenAnswer((answer) async => null);
      var ok = await authService.register(user);
      expect(ok, true);
    });

  });
}