import 'package:flutter/material.dart';

class ImageWrapper extends StatelessWidget {
  final ImageProvider provider;
  final BoxFit boxFit;
  const ImageWrapper({
    Key? key,
    required this.provider,
    this.boxFit = BoxFit.contain,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image(
      image: provider,
      fit: boxFit,
      loadingBuilder: (context, child, event) {
        if (event?.cumulativeBytesLoaded == event?.expectedTotalBytes) {
          return child;
        }
        return SizedBox(
          width: 55,
          height: 55,
          child: Center(
            child: CircularProgressIndicator(
              value: (event?.cumulativeBytesLoaded ?? 1) /
                  (event?.expectedTotalBytes ?? 1),
            ),
          ),
        );
      },
    );
  }
}
