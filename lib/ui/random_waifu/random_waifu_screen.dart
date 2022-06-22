import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:waifu/service/model/waifu_image.dart';
import 'package:waifu/ui/random_waifu/widgets/waifu_viewer.dart';
import 'random_waifu_wm.dart';

class RandomWaifuScreen extends ElementaryWidget<IRandomWaifuWidgetModel> {
  const RandomWaifuScreen({
    Key? key,
    WidgetModelFactory wmFactory = defaultRandomWaifuWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(IRandomWaifuWidgetModel wm) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Random waifu'),
        actions: [
          IconButton(
            onPressed: wm.onCopyLink,
            icon: const Icon(Icons.copy_rounded),
          ),
        ],
      ),
      floatingActionButton: EntityStateNotifierBuilder<WaifuImage>(
        listenableEntityState: wm.image,
        builder: (_, data) {
          final loaded = data != null;
          return FloatingActionButton(
            onPressed: loaded ? wm.onRefresh : null,
            child: const Icon(Icons.refresh_rounded),
          );
        },
      ),
      body: EntityStateNotifierBuilder<WaifuImage>(
        listenableEntityState: wm.image,
        loadingBuilder: (_, __) => const Center(
          child: CircularProgressIndicator(),
        ),
        errorBuilder: (context, error, data) {
          if (data != null) {
            return WaifuViewer(image: data);
          }
          return const Center(
            child: Text('Ошибка загрузки данных'),
          );
        },
        builder: (context, data) {
          if (data != null) {
            return WaifuViewer(image: data);
          }
          return const SizedBox();
        },
      ),
    );
  }
}
