import 'package:busha_app/misc/dark_light_control.dart';
import 'package:busha_app/services/auth.dart';
import 'package:busha_app/services/blockchain.dart';
import 'package:busha_app/services/net.dart';
import 'package:busha_app/util/prefs.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../util/functions.dart';

class RegisterServices {
  static Future register() async {
    const mm = '🍎🍎🍎🍎🍎🍎 RegisterServices';
    pp('$mm registerServices: initialize service singletons with GetIt .... 🍎🍎🍎');

    var prefs = Prefs(await SharedPreferences.getInstance());
    var dlc = DarkLightControl(prefs);

    GetIt.instance.registerLazySingleton<AuthService>(
            () => AuthService(prefs));

    GetIt.instance.registerLazySingleton<BlockchainService>(
            () => BlockchainService());

    GetIt.instance.registerLazySingleton<Prefs>(
            () => prefs);

    GetIt.instance.registerLazySingleton<DarkLightControl>(
            () => dlc);


    pp('$mm registerServices: service singletons set up: 🍎 [AuthService, BlockchainService]  🍎🍎');
    Net.sayHello();
  }
}