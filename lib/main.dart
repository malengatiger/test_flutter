import 'dart:async';

import 'package:busha_app/misc/dark_light_control.dart';
import 'package:busha_app/models/mode_and_color.dart';
import 'package:busha_app/services/register_services.dart';
import 'package:busha_app/ui/landing/landing_page.dart';
import 'package:busha_app/ui/on_boarding/color_gallery.dart';
import 'package:busha_app/util/functions.dart';
import 'package:busha_app/util/prefs.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';

const mm = '🍐 🍐 🍐 BushaApp';

late StreamSubscription<ModeAndColor> nodeSubscription;

Future<void> main() async {
  pp('$mm  App starting .... ');
  WidgetsFlutterBinding.ensureInitialized();
  var app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  pp('$mm ... Firebase initialized: ${app.name}');
  pp('$mm Firebase options: ${app.options.asMap}');
  try {
    var reg =
    RegisterServices(await SharedPreferences.getInstance());
  } catch (e) {
    pp('$mm Problem with RegisterServices? $e');
  }

  runApp(const MyApp());
  pp('$mm app is running!');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ModeListener dlc = GetIt.instance<ModeListener>();
    Prefs prefs = GetIt.instance<Prefs>();
    ModeAndColor modeColor = prefs.getModeAndColor();
    Color mColor = getColors().elementAt(modeColor.colorIndex!);

    return StreamBuilder<ModeAndColor>(
        stream: dlc.darkLightStream,
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            pp('$mm ... snapshot has data, mode: ${snapshot.data!.mode} '
                '- colorIndex: ${snapshot.data!.colorIndex}');
            modeColor = snapshot.data!;
            mColor = getColors().elementAt(modeColor.colorIndex!);
          }
          pp('$mm ...  mode: ${modeColor.mode} - modeAndColor: ${modeColor.toJson()}');
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              // fontFamily: GoogleFonts.openSans().fontFamily,
              pageTransitionsTheme: const PageTransitionsTheme(),
              colorScheme: ColorScheme.fromSeed(
                  brightness: modeColor.mode == mDARKMode
                      ? Brightness.dark
                      : Brightness.light,
                  seedColor: mColor),
              primaryColor: mColor,
            ),
            title: "Busha Demo",
            // home: const TezosBlockWidget(),
            // home: const TezosAccounts(),
            home: const LandingPage(),
          );
        });
  }
}

ThemeData themeDeepPurpleLight = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    useMaterial3: true, fontFamily: GoogleFonts.openSans().fontFamily,
    primaryColor: Colors.pink, primaryColorDark: Colors.pink.shade900,
    primaryColorLight: Colors.pink.shade300,
    brightness: Brightness.light);

ThemeData themeDeepPurpleDark = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    useMaterial3: true,
    brightness: Brightness.dark);
