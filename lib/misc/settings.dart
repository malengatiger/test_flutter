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
  bool _darkMode = false;
  int _selectedColorIndex = 0;

  final List<Color> _colors = [
    Colors.red,
    Colors.pink,
    Colors.purple,
    Colors.deepPurple,
    Colors.indigo,
    Colors.blue,
    Colors.lightBlue,
    Colors.cyan,
    Colors.teal,
    Colors.green,
    Colors.lightGreen,
    Colors.lime,
  ];

  Prefs prefs = GetIt.instance<Prefs>();
  DarkLightControl darkLightControl = GetIt.instance<DarkLightControl>();

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  late ModeAndColor _modeAndColor;

  Future<void> _loadSettings() async {
    var mode = setState(() {
      _modeAndColor = prefs.getModeAndColor();
      if (_modeAndColor.colorIndex! > -1) {
        _selectedColorIndex = _modeAndColor.colorIndex!;
      }
    });
    setState(() {});
  }

  Future<void> _saveModeAndColor() async {
    prefs.saveModeAndColor(_modeAndColor);
    if (_darkMode) {
      darkLightControl.setDarkMode(_selectedColorIndex);
    } else {
      darkLightControl.setLightMode(_selectedColorIndex);
    }
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
                      title: const Text('General'),
                      tiles: [
                        SettingsTile.switchTile(
                          title: Text(_darkMode ? 'Dark Mode' : 'Light Mode'),
                          leading: const Icon(Icons.brightness_2),
                          onToggle: (value) {
                            pp(' onToggle: mode setting: $value - _selectedColorIndex: $_selectedColorIndex');
                            _darkMode = value;
                            _saveModeAndColor();
                          },
                          initialValue: _darkMode,
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
                      _selectedColorIndex = index;
                      _saveModeAndColor();
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
