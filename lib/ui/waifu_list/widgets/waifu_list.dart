import 'package:flutter/material.dart';
import 'package:masonry_grid/masonry_grid.dart';
import 'package:waifu/service/model/waifu_image.dart';
import 'package:waifu/service/model/waifu_image_list.dart';
import 'package:waifu/ui/waifu_list/widgets/waifu_tile.dart';

class WaifuList extends StatelessWidget {
  final WaifuImageList imageList;
  final RefreshCallback onRefresh;

  final bool usePluginVersion;

  const WaifuList({
    Key? key,
    required this.imageList,
    required this.onRefresh,
    this.usePluginVersion = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return RefreshIndicator(
        onRefresh: onRefresh,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverToBoxAdapter(
                child: MasonryGrid(
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  column: constraints.maxHeight > constraints.maxWidth ? 2 : 3,
                  children: [
                    for (var image in imageList.images)
                      WaifuTile(
                        image: WaifuImage(image),
                      ),
                  ],
                ),
              ),
            )
            // else
            //   SliverPadding(
            //     padding: const EdgeInsets.symmetric(horizontal: 8),
            //     sliver: SliverToBoxAdapter(
            //       child: OrientationBuilder(builder: (context, orientation) {
            //         int columns = 2;
            //         if (orientation == Orientation.landscape) {
            //           columns = 3;
            //         }

            //         return Row(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             for (int column
            //                 in List.generate(columns, (index) => index))
            //               Expanded(
            //                 child: Column(
            //                   children: [
            //                     for (var image in imageList.images
            //                         .getRange(column, 10 * column))
            //                       WaifuTile(image: WaifuImage(image)),
            //                   ],
            //                 ),
            //               ),
            //             // Expanded(
            //             //   child: Column(
            //             //     children: [
            //             //       for (var image in imageList.images.getRange(16, 30))
            //             //         WaifuTile(image: WaifuImage(image)),
            //             //     ],
            //             //   ),
            //             // ),
            //           ],
            //         );
            //       }),
            //     ),
            //   ),
          ],
        ),
      );
    });
  }
}
