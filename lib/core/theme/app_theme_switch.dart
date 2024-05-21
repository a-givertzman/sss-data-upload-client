import 'package:flutter/material.dart';
import 'package:hmi_core/hmi_core.dart';
import 'package:hmi_widgets/hmi_widgets.dart';
/// Provide access to data corresponding to app theme
class AppThemeSwitch with ChangeNotifier {
  static const _debug = true;
  late ThemeData _themeData;
  AppTheme _theme = AppTheme.dark;
  ThemeMode _themeMode = ThemeMode.light;
  /// Returns app's [AppTheme]
  AppTheme get theme => _theme;
  /// Returns app's [ThemeMode]
  ThemeMode get themeMode => _themeMode;
  /// Returns app's [ThemeData]
  ThemeData get themeData => _themeData;
  /// Creates and configures [AppThemeSwitch]
  AppThemeSwitch() : super() {
    log(_debug, '[$AppThemeSwitch]');
    if (appThemes.containsKey(_theme)) {
      final defaultThemeData = appThemes[_theme];
      if (defaultThemeData != null) {
        _themeData = defaultThemeData;
      } else {
        throw _unexpectedFailure();
      }
    } else {
      throw _unexpectedFailure();
    }
  }
  /// Switches app's [ThemeMode] to provided [mode]
  void toggleMode(ThemeMode? mode) {
    if (mode != null) {
      _themeMode = mode;
    }
    notifyListeners();
  }
  /// Switches app's [AppTheme] to provided [theme]
  void toggleTheme(AppTheme? theme) {
    log(_debug, '[$AppThemeSwitch.toggleTheme()] theme: $theme');
    if (theme != null) {
      if (appThemes.containsKey(theme)) {
        _theme = theme;
        final appTheme = appThemes[theme];
        if (appTheme != null) {
          _themeData = appTheme;
        }
      } else {
        throw _unexpectedFailure();
      }
    }
    notifyListeners();
  }
  ///
  Failure _unexpectedFailure() {
    return Failure.unexpected(
      message: '[$AppThemeSwitch] несуществующая тема $_themeMode',
      stackTrace: StackTrace.current,
    );
  }
}
