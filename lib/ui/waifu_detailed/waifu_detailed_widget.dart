import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:waifu/ui/random_waifu/widgets/waifu_viewer.dart';
import 'waifu_detailed_wm.dart';

class WaifuDetailedWidget extends ElementaryWidget<IWaifuDetailedWidgetModel> {
  const WaifuDetailedWidget({
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
          ? WaifuViewer(
              image: wm.image!,
            )
          : const Icon(Icons.error),
    );
  }
}
