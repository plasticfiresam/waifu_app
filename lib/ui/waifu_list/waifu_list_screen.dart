import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:waifu/service/model/waifu_image_list.dart';
import 'package:waifu/ui/waifu_list/waifu_list_wm.dart';
import 'package:waifu/ui/waifu_list/widgets/waifu_list.dart';

class WaifuListScreen extends ElementaryWidget<WaifuListWM> {
  const WaifuListScreen({
    Key? key,
    WidgetModelFactory wmFactory = createWaifuListWM,
  }) : super(wmFactory, key: key);

  @override
  Widget build(WaifuListWM wm) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.filter_alt_rounded),
        onPressed: () {},
      ),
      appBar: AppBar(
        title: const Text('Waifu list'),
      ),
      body: EntityStateNotifierBuilder<WaifuImageList?>(
        listenableEntityState: wm.images,
        errorBuilder: (_, __, ___) {
          return const Center(
            child: Text('Ошибка загрузки вайфу'),
          );
        },
        builder: (context, value) {
          if (value == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return WaifuList(
            onRefresh: () async {
              wm.refreshList();
              return wm.refreshCompleter?.future ?? Future.value();
            },
            imageList: value,
          );
        },
      ),
    );
  }
}
