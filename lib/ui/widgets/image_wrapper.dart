import 'package:flutter/material.dart';

class ImageWrapper extends StatelessWidget {
  final ImageProvider provider;
  const ImageWrapper({
    Key? key,
    required this.provider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image(
      image: provider,
      fit: BoxFit.contain,
      frameBuilder: (_, child, __, ___) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: child,
        );
      },
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
