import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:waifu/service/constants/waifu_categories.dart';
import 'package:waifu/service/model/waifu_image_list.dart';
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
  Widget build(WaifuListWidgetModel wm) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          wm.onOpenRandom();
        },
        label: const Text('I`m feeling lucky'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: RefreshIndicator(
        onRefresh: () async {
          wm.refreshList();
          return wm.refreshCompleter?.future ?? Future.value();
        },
        child: Scrollbar(
          child: CustomScrollView(
            controller: wm.scrollController,
            physics: const BouncingScrollPhysics(),
            slivers: [
              const SliverAppBar(
                pinned: true,
                title: Text('Waifu list'),
                primary: true,
              ),
              SliverStickyHeader(
                controller: wm.stickyHeaderController,
                overlapsContent: false,
                header: WaifuCategoriesSelector(
                  expandedState: wm.categoriesExpanded,
                  currentCategory: wm.category,
                  categories: waifuCategories[WaifuType.sfw]!,
                  onOpenSelector: () {
                    wm.onToggleCategoriesPanel();
                  },
                  onChangeCategory: (String category) {
                    wm.onChangeCategory(category);
                    wm.onToggleCategoriesPanel();
                  },
                ),
                sliver: SliverPadding(
                  padding: const EdgeInsets.all(16),
                  sliver: SliverToBoxAdapter(
                    child: EntityStateNotifierBuilder<WaifuImageList?>(
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
                          imageList: value,
                          onTap: (waifu) {
                            wm.openDetails(waifu);
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
