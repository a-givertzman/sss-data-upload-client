import 'dart:async';
import 'package:flutter/material.dart' hide Localizations;
import 'package:hmi_core/hmi_core.dart';
import 'package:sss_data_upload_client/app_widget.dart';
import 'package:sss_data_upload_client/core/theme/app_theme_switch.dart';
void main() async {
  Log.initialize(level: LogLevel.warning);
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await Localizations.initialize(
        AppLang.en,
        jsonMap: JsonMap.fromTextFile(
          const TextFile.asset('assets/translations/translations.json'),
        ),
      );
      await AppSettings.initialize(
        jsonMap: JsonMap.fromTextFile(
          const TextFile.asset(
            'assets/settings/app-settings.json',
          ),
        ),
      );
      final appThemeSwitch = AppThemeSwitch();
      runApp(AppWidget(themeSwitch: appThemeSwitch));
    },
    (error, stackTrace) {
      final trace = stackTrace.toString().isEmpty
          ? StackTrace.current
          : stackTrace.toString();
      const Log('main').error('message: $error\nstackTrace: $trace');
    },
  );
}
