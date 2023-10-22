import 'package:flutter/material.dart';
import './imgy.dart';
import './imgy_utils.dart';
import './imgy_images.dart';

class ImgyThumbnail extends StatelessWidget {
  const ImgyThumbnail({
    super.key,
    required this.widget,
  });

  final Imgy widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('imgy_preview_container'),
      padding: EdgeInsets.all(widget.padding),
      decoration: BoxDecoration(
        borderRadius: widget.borderRadius,
        border: Border.all(
          color: widget.borderColor,
          width: widget.borderWidth,
        ),
      ),
      child: ClipRRect(
        borderRadius: widget.borderRadiusInside ?? widget.borderRadius,
        child: ColoredBox(
          color: widget.placeholderColor,
          child: checkSrc(widget.src)
              ? ImgyWebImage(widget: widget)
              : ImgyAssetImage(widget: widget),
        ),
      ),
    );
  }
}
