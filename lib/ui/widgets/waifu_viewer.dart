import 'package:flutter/material.dart';
import 'package:waifu/ui/widgets/image_wrapper.dart';

class WaifuViewer extends StatelessWidget {
  final ImageProvider image;
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
            child: ImageWrapper(provider: image),
          ),
        ),
      ],
    );
  }
}
