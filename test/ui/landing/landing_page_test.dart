import 'package:busha_app/firebase_options.dart';
import 'package:busha_app/misc/dark_light_control.dart';
import 'package:busha_app/services/auth.dart';
import 'package:busha_app/ui/landing/landing_page.dart';
import 'package:busha_app/util/functions.dart';
import 'package:busha_app/util/prefs.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'landing_page_test.mocks.dart';

// Generate mocks using:
// flutter pub run build_runner build
@GenerateMocks([Prefs, ModeListener, AuthService])
void main() {
  late MockPrefs mockPrefs;
  late MockModeListener mockModeListener;
  late MockAuthService mockAuthService;

  final testGetIt = GetIt.instance;

  ModeListener getModeListener() {
    bool testing = true;
    if (testing) {
      return testGetIt.get<ModeListener>();
    } else {
      return testGetIt.get<ModeListener>();
    }
  }

  setUp(() async {
    WidgetsFlutterBinding.ensureInitialized();

    testGetIt.reset();
    mockPrefs = MockPrefs();
    mockModeListener = MockModeListener();
    mockAuthService = MockAuthService();
    testGetIt.registerSingleton<ModeListener>(mockModeListener);
    testGetIt.registerSingleton<Prefs>(mockPrefs);
    testGetIt.registerSingleton<AuthService>(mockAuthService);

    // Stub the getUser method
    when(mockPrefs.getUser()).thenReturn(null);
    when(mockAuthService.isSignedIn())
        .thenAnswer((_) async => true); // Or true, as needed
  });

  group('LandingPage Widget Tests', () {
    testWidgets('LandingPage has sign in and register', (tester) async {
      // Build the LandingPage widget
      await tester.pumpWidget(const MaterialApp(home: LandingPage()));

      // Create the Finders (adjust based on actual text in LandingPage)
      final text1 = find.textContaining('Sign In'); // Case-insensitive search
      final text2 = find.text('Register');
      final text3 = find.text('Go to your account');
      final text4 = find.text('No account yet?');

      // Verify that the Text widgets appear in the widget tree
      expect(text1, findsOneWidget);
      expect(text2, findsOneWidget);
      expect(text3, findsOneWidget);
      expect(text4, findsOneWidget);
    });
  });
}
