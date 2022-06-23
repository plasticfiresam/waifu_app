import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:waifu/ui/widgets/waifu_viewer.dart';
import 'waifu_detailed_wm.dart';

class WaifuDetailedScreen extends ElementaryWidget<IWaifuDetailedWidgetModel> {
  const WaifuDetailedScreen({
    Key? key,
    WidgetModelFactory wmFactory = defaultWaifuDetailedWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(IWaifuDetailedWidgetModel wm) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Waifu'),
      ),
      body: wm.image != null
          ? WaifuViewer(image: wm.image!)
          : const Center(child: Icon(Icons.error)),
    );
  }
}
