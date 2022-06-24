import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:swipable_stack/swipable_stack.dart';
import 'package:waifu/ui/widgets/image_wrapper.dart';
import 'waifu_tinder_wm.dart';

/// Main widget for WaifuTinder module
class WaifuTinderScreen extends ElementaryWidget<IWaifuTinderWidgetModel> {
  const WaifuTinderScreen({
    Key? key,
    WidgetModelFactory wmFactory = defaultWaifuTinderWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(IWaifuTinderWidgetModel wm) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Waifu tinder'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: EntityStateNotifierBuilder<List<ImageProvider>>(
                listenableEntityState: wm.images,
                loadingBuilder: (_, __) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
                builder: (context, images) {
                  if (images?.isEmpty ?? true) {
                    return const Center(
                      child: Text('Нет вайфу'),
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: SwipableStack(
                      controller: wm.stackController,
                      onSwipeCompleted: (index, direction) {
                        switch (direction) {
                          case SwipeDirection.left:
                            wm.onDismiss(index);
                            break;
                          case SwipeDirection.right:
                            wm.onSave(index);
                            break;
                          default:
                            {}
                        }
                      },
                      builder: (context, swipeProperty) {
                        return _WaifuCard(
                          provider: images![swipeProperty.index],
                        );
                      },
                    ),
                  );
                },
              ),
            ),
            EntityStateNotifierBuilder<List<ImageProvider>>(
              listenableEntityState: wm.images,
              builder: (_, images) {
                return AnimatedOpacity(
                  opacity: (images?.isEmpty ?? true) ? 0.5 : 1,
                  duration: const Duration(milliseconds: 300),
                  child: _TinderControls(
                    onNext: () {
                      wm.stackController
                          .next(swipeDirection: SwipeDirection.right);
                    },
                    onPrev: () {
                      wm.stackController
                          .next(swipeDirection: SwipeDirection.left);
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _TinderControls extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onPrev;
  const _TinderControls({
    Key? key,
    required this.onNext,
    required this.onPrev,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          color: Colors.red,
          onPressed: onPrev,
          icon: const Icon(Icons.close),
        ),
        IconButton(
          color: Colors.green,
          onPressed: onNext,
          icon: const Icon(Icons.save),
        ),
      ],
    );
  }
}

class _WaifuCard extends StatelessWidget {
  final ImageProvider provider;
  const _WaifuCard({
    Key? key,
    required this.provider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      type: MaterialType.card,
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: ImageWrapper(
                    provider: provider,
                    boxFit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
