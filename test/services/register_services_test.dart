import 'package:busha_app/misc/dark_light_control.dart';
import 'package:busha_app/services/auth.dart';
import 'package:busha_app/services/blockchain.dart';
import 'package:busha_app/services/net.dart';
import 'package:busha_app/services/news_service.dart';
import 'package:busha_app/services/register_services.dart';
import 'package:busha_app/util/news_refresh_listener.dart';
import 'package:busha_app/util/prefs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'register_services_test.mocks.dart';

// Generate mocks using:
// flutter pub run build_runner build


@GenerateMocks([SharedPreferences, Client, Net])
void main() {
  late MockSharedPreferences mockSharedPreferences;


  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    GetIt.asNewInstance();
  });

  group('Register App Services', () {
    test('Registers all Busha services', () async {

      WidgetsFlutterBinding.ensureInitialized();
      // Call the register method.
      var reg = RegisterServices(mockSharedPreferences);

      await reg.register();
      // Verify that all services are registered.
      expect(GetIt.instance.isRegistered<Net>(), true);
      expect(GetIt.instance.isRegistered<NewsRefreshListener>(), true);
      expect(GetIt.instance.isRegistered<AuthService>(), true);
      expect(GetIt.instance.isRegistered<BlockchainService>(), true);
      expect(GetIt.instance.isRegistered<Prefs>(), true);
      expect(GetIt.instance.isRegistered<ModeListener>(), true);
      expect(GetIt.instance.isRegistered<NewsService>(), true);

    });
  });
}