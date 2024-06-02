import 'package:busha_app/models/user.dart';
import 'package:busha_app/services/auth.dart';
import 'package:busha_app/util/prefs.dart';
import 'package:firebase_auth/firebase_auth.dart' as m_auth;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'services/auth_test.mocks.dart';


// Generate mocks using:
// flutter pub run build_runner build

@GenerateMocks([m_auth.FirebaseAuth, m_auth.UserCredential, m_auth.User, Prefs])
void main() {
  late MockFirebaseAuth mockFirebaseAuth;
  late MockUserCredential mockUserCredential;
  late MockUser mockUser;
  late MockPrefs mockPrefs;
  late AuthService authService;

  setUp(() {
    // Initialize mocks
    mockFirebaseAuth = MockFirebaseAuth();
    mockUserCredential = MockUserCredential();
    mockUser = MockUser();
    mockPrefs = MockPrefs();

    // Create AuthService instance with mock FirebaseAuth
    authService = AuthService(mockFirebaseAuth);

    // Stub methods that will be called during the test
    when(mockFirebaseAuth.signInWithEmailAndPassword(email: anyNamed('email'), password: anyNamed('password')))
        .thenAnswer((_) async => mockUserCredential);
    when(mockPrefs.saveUser(any)).thenAnswer((_) async {}); // Stub saveUser to do nothing
  });

  group('AuthService - signIn', () {
    test('signs in user successfully', () async {
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

      // Verify that saveUser was called with the expected User object
      // verify(mockPrefs.saveUser(any)).called(1);
    });

    // Add more tests for different scenarios like:
    // - sign-in failure (when mockUserCredential.user is null)
    // - exceptions during sign-in
  });
}