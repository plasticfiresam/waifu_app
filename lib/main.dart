import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:waifu/app_model.dart';
import 'package:waifu/service/navigation_helper.dart';
import 'package:waifu/service/waifu_service.dart';
import 'package:waifu/waifu_app.dart';

GetIt getIt = GetIt.instance;

void main() {
  /// for google_fonts purposes
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });

  getIt
    ..registerSingleton<AppModel>(AppModel())
    ..registerSingleton<WaifuService>(WaifuService())
    ..registerSingleton<NavigationHelper>(NavigationHelper());

  runApp(const WaifuApp());
}
