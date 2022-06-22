import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:waifu/service/model/waifu_image.dart';

typedef OnWaifuTapCallback = Function(WaifuImage);

class WaifuTile extends StatelessWidget {
  final WaifuImage image;
  final OnWaifuTapCallback? onTap;

  const WaifuTile({
    Key? key,
    required this.image,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 55),
      child: LimitedBox(
        maxHeight: 300,
        child: Material(
          type: MaterialType.card,
          borderRadius: BorderRadius.circular(24),
          clipBehavior: Clip.antiAlias,
          child: GestureDetector(
            onTap: onTap != null ? () => onTap!(image) : null,
            child: DecoratedBox(
              decoration: const BoxDecoration(
                color: Color.fromARGB(1, 13, 9, 8),
              ),
              child: CachedNetworkImage(
                fit: BoxFit.contain,
                fadeInDuration: const Duration(milliseconds: 300),
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
      ),
    );
  }
}
