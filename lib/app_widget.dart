import 'package:flutter/material.dart';
import 'package:hmi_core/hmi_core_app_settings.dart';
import 'package:sss_data_upload_client/core/theme/app_theme_switch.dart';
import 'package:window_manager/window_manager.dart';
/// Main widget of flutter application
class AppWidget extends StatefulWidget {
  final AppThemeSwitch _themeSwitch;
  /// Creates [AppWidget]
  const AppWidget({
    super.key,
    required AppThemeSwitch themeSwitch,
  }) : _themeSwitch = themeSwitch;
  //
  @override
  State<AppWidget> createState() => _AppWidgetState(themeSwitch: _themeSwitch);
}
///
class _AppWidgetState extends State<AppWidget> {
  final AppThemeSwitch _themeSwitch;
  ///
  _AppWidgetState({
    required AppThemeSwitch themeSwitch,
  }) : _themeSwitch = themeSwitch;
  //
  @override
  void initState() {
    super.initState();
    _themeSwitch.addListener(_themeSwitchListener);
    Future.delayed(
      Duration.zero,
      () async {
        await windowManager.ensureInitialized();
        windowManager.waitUntilReadyToShow(
          WindowOptions(
            size: Size(
              const Setting('displaySizeWidth').toDouble,
              const Setting('displaySizeHeight').toDouble,
            ),
            center: true,
            backgroundColor: Colors.transparent,
            skipTaskbar: false,
          ),
          () async {
            await windowManager.show();
            await windowManager.focus();
          },
        );
      },
    );
  }
  //
  @override
  void dispose() {
    _themeSwitch.removeListener(_themeSwitchListener);
    super.dispose();
  }
  //
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _themeSwitch.themeData,
      home: const Scaffold(
        body: const Text('Empty scaffold'),
      ),
    );
  }
  ///
  void _themeSwitchListener() {
    if (mounted) {
      setState(() {
        return;
      });
    }
  }
}
