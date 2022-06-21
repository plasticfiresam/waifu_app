import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:waifu/service/model/waifu_image.dart';

class WaifuTile extends StatelessWidget {
  final WaifuImage image;
  const WaifuTile({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 55),
      child: LimitedBox(
        maxWidth: (MediaQuery.of(context).size.width / 2) - 8,
        maxHeight: 300,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: DecoratedBox(
            decoration: const BoxDecoration(
              color: Color.fromARGB(1, 13, 9, 8),
            ),
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: image.url,
              placeholder: (context, _) {
                return const SizedBox(
                  width: 55,
                  height: 55,
                  child: Center(
                    child: CupertinoActivityIndicator(),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
