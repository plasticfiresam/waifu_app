import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:waifu/service/navigation_helper.dart';
import 'package:waifu/service/waifu_service.dart';
import 'package:waifu/waifu_app.dart';

GetIt getIt = GetIt.instance;

void main() {
  getIt
    ..registerSingleton<WaifuService>(WaifuService())
    ..registerSingleton<NavigationHelper>(NavigationHelper());

  runApp(const WaifuApp());
}
