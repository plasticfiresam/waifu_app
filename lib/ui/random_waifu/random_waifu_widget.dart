import 'package:cached_network_image/cached_network_image.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:waifu/service/model/waifu_image.dart';
import 'random_waifu_wm.dart';

// TODO: cover with documentation
/// Main widget for RandomWaifu module
class RandomWaifuWidget extends ElementaryWidget<IRandomWaifuWidgetModel> {
  const RandomWaifuWidget({
    Key? key,
    WidgetModelFactory wmFactory = defaultRandomWaifuWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(IRandomWaifuWidgetModel wm) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Random waifu'),
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
        builder: (context, data) {
          if (data != null) {
            return Stack(
              children: [
                Positioned.fill(
                  child: InteractiveViewer(
                    child: CachedNetworkImage(
                      imageUrl: data.url,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
