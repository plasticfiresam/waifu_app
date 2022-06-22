import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:waifu/service/constants/waifu_categories.dart';
import 'package:waifu/service/model/waifu_image_list.dart';
import 'package:waifu/ui/waifu_list/waifu_list_wm.dart';
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
      appBar: AppBar(
        title: const Text('Waifu list'),
      ),
      body: RefreshIndicator(
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
                  child: EntityStateNotifierBuilder<bool>(
                    listenableEntityState: wm.categoriesExpanded,
                    builder: (context, isExpanded) {
                      return Material(
                        type: MaterialType.card,
                        borderRadius: BorderRadius.circular(24),
                        clipBehavior: Clip.antiAlias,
                        child: ExpansionPanelList(
                          elevation: 0,
                          expansionCallback: (panelIndex, bool isExpanded) {
                            if (panelIndex == 0) {
                              wm.onToggleCategoriesPanel();
                            }
                          },
                          children: [
                            ExpansionPanel(
                              backgroundColor: const Color(0xffefefef),
                              isExpanded: isExpanded ?? false,
                              canTapOnHeader: true,
                              headerBuilder: (context, isExpanded) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Category',
                                        style: TextStyle(
                                          fontSize: isExpanded ? 20 : 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      AnimatedOpacity(
                                        opacity: isExpanded ? 0 : 1,
                                        duration:
                                            const Duration(milliseconds: 300),
                                        child: Text(
                                          wm.category,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                              body: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
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
                                            wm.onToggleCategoriesPanel();
                                          }
                                        },
                                      )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              SliverPadding(
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
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
