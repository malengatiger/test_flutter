import 'package:busha_app/misc/dark_light_control.dart';
import 'package:busha_app/models/mode_and_color.dart';
import 'package:busha_app/ui/on_boarding/color_gallery.dart';
import 'package:busha_app/util/functions.dart';
import 'package:busha_app/util/gaps.dart';
import 'package:busha_app/util/prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';
import 'package:get_it/get_it.dart';

class SettingsWidget extends StatefulWidget {
  const SettingsWidget({super.key});

  @override
  State<SettingsWidget> createState() => SettingsWidgetState();
}

class SettingsWidgetState extends State<SettingsWidget> {
  // int _selectedColorIndex = 0;


  Prefs prefs = GetIt.instance<Prefs>();
  ModeListener modeListener = GetIt.instance<ModeListener>();

  @override
  void initState() {
    super.initState();
    loadSettings();
  }

  late ModeAndColor modeAndColor;

  Future<void> loadSettings() async {
    modeAndColor = prefs.getModeAndColor();
    await Future.delayed(const Duration(milliseconds: 100));
    setState(() {});
  }

  Future<void> saveModeAndColor() async {
    prefs.saveModeAndColor(modeAndColor);
    modeListener.setMode(modeAndColor);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: Theme.of(context).textTheme.headlineLarge?.fontSize),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Set it up like you like!',
                style: TextStyle(
                    color: Theme.of(context).primaryColor, fontStyle: FontStyle.italic,
                    fontSize:
                        Theme.of(context).textTheme.headlineSmall?.fontSize),
              ),
              SizedBox(
                height: 100,
                child: SettingsList(
                  sections: [
                    SettingsSection(
                      title: const Text('Mode and Color'),
                      tiles: [
                        SettingsTile.switchTile(
                          title: Text(modeAndColor.mode == mDARKMode ? 'Dark Mode' : 'Light Mode'),
                          leading: const Icon(Icons.brightness_2),
                          onToggle: (value) {
                            modeAndColor.mode = value? mDARKMode : mLIGHTMode;
                            pp(' onToggle: _modeAndColor setting: ${modeAndColor.toJson()}');
                            saveModeAndColor();
                          },
                          initialValue: modeAndColor.mode == mDARKMode? true: false,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                  height: 480,
                  child: ColorGallery(
                    onColorSelected: (index) {
                      modeAndColor.colorIndex = index;
                      saveModeAndColor();
                    },
                  )),
              gapH32,
            ],
          ),
        ),
      ),
    );
  }
}
