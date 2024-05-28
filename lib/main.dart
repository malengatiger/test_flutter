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

import 'firebase_options.dart';

const mm = '🍐 🍐 🍐 BushaApp';

late StreamSubscription<ModeAndColor> nodeSubscription;

Future<void> main() async {
  pp('$mm  App starting .... ');
  WidgetsFlutterBinding.ensureInitialized();
  var app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  pp('$mm Firebase initialized: ${app.name}');
  pp('$mm Firebase options: ${app.options.asMap}');
  try {
    await RegisterServices.register();
  } catch (e) {
    pp('Problem? $e');
  }

  runApp(const MyApp());
  pp('$mm app is running!');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    DarkLightControl dlc = GetIt.instance<DarkLightControl>();
    Prefs prefs = GetIt.instance<Prefs>();

    return StreamBuilder<ModeAndColor>(
        stream: dlc.darkLightStream,
        builder: (_, snapshot) {
          Color mColor = Colors.red;
          ModeAndColor modeColor = prefs.getModeAndColor();
          int? mode = mLIGHTMode;
          if (snapshot.hasData) {
            pp('$mm ... snapshot has data, mode: ${snapshot.data!.mode} - colorIndex: ${snapshot.data!.colorIndex}');
            modeColor = snapshot.data!;
            mColor = getColors().elementAt(modeColor.colorIndex!);
            mode = modeColor.mode;
          }
          pp('$mm ...  mode: $mode - modeColor: ${modeColor.toJson()}');
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: GoogleFonts.openSans().fontFamily,
              pageTransitionsTheme: const PageTransitionsTheme(),
              colorScheme: ColorScheme.fromSeed(
                  brightness: mode == 0 ? Brightness.dark : Brightness.light,
                  seedColor: mColor),
              primaryColor: mColor,
            ),
            title: "Busha Demo",
            home: const LandingPage(),
          );
        });
  }
}

ThemeData themeDeepPurpleLight = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    useMaterial3: true,
    brightness: Brightness.light);

ThemeData themeDeepPurpleDark = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    useMaterial3: true,
    brightness: Brightness.dark);
