import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';

typedef OnChangeCategory = Function(String);

class WaifuCategoriesSelector extends StatelessWidget {
  final List<String> categories;
  final ValueNotifier<String> currentCategory;
  final VoidCallback onOpenSelector;
  final OnChangeCategory onChangeCategory;
  final ListenableState<EntityState<bool>> expandedState;
  const WaifuCategoriesSelector({
    Key? key,
    required this.categories,
    required this.currentCategory,
    required this.onOpenSelector,
    required this.onChangeCategory,
    required this.expandedState,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 8,
      ),
      child: Material(
        type: MaterialType.card,
        borderRadius: BorderRadius.circular(24),
        clipBehavior: Clip.antiAlias,
        child: EntityStateNotifierBuilder<bool>(
            listenableEntityState: expandedState,
            builder: (context, isExpanded) {
              return ExpansionPanelList(
                elevation: 0,
                expansionCallback: (panelIndex, bool isExpanded) {
                  if (panelIndex == 0) {
                    onOpenSelector();
                  }
                },
                children: [
                  ExpansionPanel(
                    backgroundColor: const Color(0xffefefef),
                    isExpanded: isExpanded ?? false,
                    canTapOnHeader: true,
                    headerBuilder: (context, isExpanded) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              duration: const Duration(milliseconds: 300),
                              child: ValueListenableBuilder<String>(
                                valueListenable: currentCategory,
                                builder: (context, data, _) {
                                  return Text(
                                    data,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  );
                                },
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
                          for (String category in categories)
                            FilterChip(
                              label: Text(category),
                              selected: currentCategory == category,
                              onSelected: (bool value) {
                                if (value) {
                                  onChangeCategory(category);
                                }
                              },
                            )
                        ],
                      ),
                    ),
                  )
                ],
              );
            }),
      ),
    );
  }
}
