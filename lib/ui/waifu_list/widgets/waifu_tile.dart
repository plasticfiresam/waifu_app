import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef OnWaifuTapCallback = Function(ImageProvider);

class WaifuTile extends StatelessWidget {
  final ImageProvider image;
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
              child: Image(
                image: image,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, event) {
                  if (event?.cumulativeBytesLoaded ==
                      event?.expectedTotalBytes) {
                    return child;
                  }
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
