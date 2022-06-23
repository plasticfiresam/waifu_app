import 'package:flutter/material.dart';
import 'package:masonry_grid/masonry_grid.dart';
import 'package:waifu/ui/waifu_list/widgets/waifu_tile.dart';

class WaifuList extends StatelessWidget {
  final List<ImageProvider> imageList;
  final OnWaifuTapCallback? onTap;
  const WaifuList({
    Key? key,
    required this.imageList,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return MasonryGrid(
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          column: constraints.maxHeight > constraints.maxWidth ? 2 : 3,
          children: [
            for (var image in imageList)
              WaifuTile(
                onTap: onTap,
                image: image,
              ),
          ],
        );
      },
    );
  }
}
