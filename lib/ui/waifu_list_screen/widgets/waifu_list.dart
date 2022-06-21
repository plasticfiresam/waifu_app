import 'package:flutter/material.dart';
import 'package:waifu/service/model/waifu_image.dart';
import 'package:waifu/service/model/waifu_image_list.dart';
import 'package:waifu/ui/waifu_list_screen/widgets/waifu_tile.dart';

class WaifuList extends StatelessWidget {
  final WaifuImageList imageList;
  final RefreshCallback onRefresh;

  const WaifuList({
    Key? key,
    required this.imageList,
    required this.onRefresh,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            sliver: SliverToBoxAdapter(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        for (var image in imageList.images.getRange(0, 15))
                          WaifuTile(image: WaifuImage(image)),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        for (var image in imageList.images.getRange(16, 30))
                          WaifuTile(image: WaifuImage(image)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
