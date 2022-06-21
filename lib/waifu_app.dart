import 'package:flutter/material.dart';
import 'package:waifu/ui/waifu_list_screen/waifu_list_screen.dart';

class WaifuApp extends StatelessWidget {
  const WaifuApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Waifu App',
      theme: ThemeData(),
      home: const WaifuListScreen(),
    );
  }
}
