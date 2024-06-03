import 'package:busha_app/misc/dark_light_control.dart';
import 'package:busha_app/misc/settings.dart';
import 'package:busha_app/models/mode_and_color.dart';
import 'package:busha_app/ui/on_boarding/color_gallery.dart';
import 'package:busha_app/util/prefs.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'settings_test.mocks.dart';

@GenerateMocks([Prefs, ModeListener])
void main() {
  late MockPrefs mockPrefs;
  late MockModeListener mockModeListener;
  final testGetIt = GetIt.instance;

  setUp(() {
    testGetIt.reset();
    mockPrefs = MockPrefs();
    mockModeListener = MockModeListener();
    testGetIt.registerSingleton<Prefs>(mockPrefs);
    testGetIt.registerSingleton<ModeListener>(mockModeListener);
  });

  group('SettingsWidgetState Tests', () {
    // test('Initial mode and color are loaded', () async {
    //   final initialModeAndColor =
    //   ModeAndColor(mode: mLIGHTMode, colorIndex: 0);
    //   when(mockPrefs.getModeAndColor()).thenReturn(initialModeAndColor);
    //
    //   final state = SettingsWidgetState();
    //   await state.loadSettings();
    //
    //   expect(state.modeAndColor, equals(initialModeAndColor));
    // });
    //
    // test('Saving mode and color updates Prefs and ModeListener', () async {
    //   final state = SettingsWidgetState();
    //   state.modeAndColor = ModeAndColor(mode: mDARKMode, colorIndex: 3);
    //
    //   await state.saveModeAndColor();
    //
    //   verify(mockPrefs.saveModeAndColor(state.modeAndColor)).called(1);
    //   verify(mockModeListener.setMode(state.modeAndColor)).called(1);
    // });
    //
    // test('Toggling switch updates mode and saves settings', () async {
    //   final state = SettingsWidgetState();
    //   state.modeAndColor = ModeAndColor(mode: mLIGHTMode, colorIndex: 0);
    //
    //   // Simulate toggling the switch to dark mode
    //   state.setState(() {
    //     state.modeAndColor.mode = mDARKMode;
    //   });
    //   await state.saveModeAndColor();
    //
    //   expect(state.modeAndColor.mode, equals(mDARKMode));
    //   verify(mockPrefs.saveModeAndColor(state.modeAndColor)).called(1);
    //   verify(mockModeListener.setMode(state.modeAndColor)).called(1);
    // });
    //
    // test('Selecting color updates colorIndex and saves settings', () async {
    //   final state = SettingsWidgetState();
    //   state.modeAndColor = ModeAndColor(mode: mLIGHTMode, colorIndex: 0);
    //
    //   // Simulate selecting a new color
    //   state.setState(() {
    //     state.modeAndColor.colorIndex = 5;
    //   });
    //   await state.saveModeAndColor();
    //
    //   expect(state.modeAndColor.colorIndex, equals(5));
    //   verify(mockPrefs.saveModeAndColor(state.modeAndColor)).called(1);
    //   verify(mockModeListener.setMode(state.modeAndColor)).called(1);
    // });
  });
}