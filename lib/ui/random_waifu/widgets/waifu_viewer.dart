import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:waifu/service/model/waifu_image.dart';

class WaifuViewer extends StatelessWidget {
  final WaifuImage image;
  const WaifuViewer({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: InteractiveViewer(
            child: CachedNetworkImage(
              imageUrl: image.url,
              fit: BoxFit.contain,
              placeholder: (context, _) {
                return const SizedBox(
                  width: 55,
                  height: 55,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
