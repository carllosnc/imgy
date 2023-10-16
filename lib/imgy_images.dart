import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import './imgy.dart';

class ImgyWebImage extends StatelessWidget {
  const ImgyWebImage({
    super.key,
    required this.widget,
  });

  final Imgy widget;

  @override
  Widget build(BuildContext context) {
    return FadeInImage(
      key: const Key('imgy_preview_image'),
      fadeInDuration: const Duration(milliseconds: 300),
      placeholder: MemoryImage(kTransparentImage),
      fit: BoxFit.cover,
      width: widget.width,
      height: widget.height,
      image: NetworkImage(
        widget.src,
      ),
    );
  }
}

class ImgyAssetImage extends StatelessWidget {
  const ImgyAssetImage({
    super.key,
    required this.widget,
  });

  final Imgy widget;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      key: const Key('imgy_preview_asset'),
      widget.src,
      fit: BoxFit.cover,
      width: widget.width,
      height: widget.height,
    );
  }
}
