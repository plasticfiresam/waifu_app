import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:waifu/service/constants/waifu_categories.dart';
import 'package:waifu/service/model/waifu_image.dart';
import 'package:waifu/service/model/waifu_type.dart';
import 'package:waifu/ui/waifu_list/waifu_list_wm.dart';
import 'package:waifu/ui/waifu_list/widgets/waifu_categories_selector.dart';
import 'package:waifu/ui/waifu_list/widgets/waifu_list.dart';

class WaifuListScreen extends ElementaryWidget<WaifuListWidgetModel> {
  const WaifuListScreen({
    Key? key,
    WidgetModelFactory wmFactory = createWaifuListWM,
  }) : super(wmFactory, key: key);

  @override
  Widget build(IWaifuListWidgetModel wm) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          wm.onOpenRandom();
        },
        label: const Text('I`m feeling lucky'),
      ),
      appBar: AppBar(
        title: const Text('Waifu list'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                WaifuCategoriesSelector(
                  expandedState: wm.categoriesExpanded,
                  currentCategory: wm.category,
                  categories: waifuCategories[WaifuType.sfw]!,
                  toggleSelectorPanel: () {
                    wm.onToggleCategoriesPanel();
                  },
                  onChangeCategory: (String category) {
                    wm.onChangeCategory(category);
                    wm.onToggleCategoriesPanel();
                  },
                ),
              ],
            ),
          ),
          Column(
            children: [
              const SizedBox(height: 64),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    wm.refreshList();
                    return wm.refreshCompleter?.future ?? Future.value();
                  },
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: EntityStateNotifierBuilder<List<ImageProvider>?>(
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
                        if (value.isEmpty) {
                          return const Center(child: Text('Список вайфу пуст'));
                        }
                        return WaifuList(
                          imageList: value,
                          onTap: (image) {
                            wm.openDetails(image);
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ].reversed.toList(),
      ),
    );
  }
}
