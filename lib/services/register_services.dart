import 'package:busha_app/misc/dark_light_control.dart';
import 'package:busha_app/services/auth.dart';
import 'package:busha_app/services/blockchain.dart';
import 'package:busha_app/services/net.dart';
import 'package:busha_app/services/news_service.dart';
import 'package:busha_app/util/news_refresh_listener.dart';
import 'package:busha_app/util/prefs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:welltested_annotation/welltested_annotation.dart';
import '../util/functions.dart';
/// Utility class to register all services to GetIt
@Welltested()
class RegisterServices {
  final SharedPreferences sharedPreferences;

  RegisterServices(this.sharedPreferences);
   Future register() async {
    const mm = '🍎🍎🍎🍎🍎🍎 RegisterServices';
    pp('$mm registerServices: initialize service singletons with GetIt .... 🍎🍎🍎');

    var modeListener = ModeListener();
    var net = Net(Client());
    var prefs = Prefs(sharedPreferences);

    GetIt.instance.registerLazySingleton<Net>(
            () => net);

    GetIt.instance.registerLazySingleton<NewsRefreshListener>(
            () => NewsRefreshListener());

    GetIt.instance.registerLazySingleton<AuthService>(
            () => AuthService(FirebaseAuth.instance, net, prefs));

    GetIt.instance.registerLazySingleton<BlockchainService>(
            () => BlockchainService(net));

    GetIt.instance.registerLazySingleton<Prefs>(
            () => prefs);

    GetIt.instance.registerLazySingleton<ModeListener>(
            () => modeListener);

    GetIt.instance.registerLazySingleton<NewsService>(
            () => NewsService());

    pp('$mm registerServices: service singletons set up: '
        '🍎 [AuthService, BlockchainService, NewsService, NewsRefreshListener, ModeListener]  🍎🍎');

    //Say hello and see if backend is up!
    // net.sayHello();
  }
}