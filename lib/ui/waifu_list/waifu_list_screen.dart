import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:waifu/service/constants/waifu_categories.dart';
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
          return RefreshIndicator(
            onRefresh: () async {
              wm.refreshList();
              return wm.refreshCompleter?.future ?? Future.value();
            },
            child: Scrollbar(
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    sliver: SliverToBoxAdapter(
                      child: Wrap(
                        spacing: 8,
                        children: [
                          for (String category
                              in waifuCategories[wm.type] ?? [])
                            FilterChip(
                              label: Text(category),
                              selected: wm.category == category,
                              onSelected: (bool value) {
                                if (value) {
                                  wm.onChangeCategory(category);
                                }
                              },
                            )
                        ],
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    sliver: SliverToBoxAdapter(
                      child: WaifuList(
                        imageList: value,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
