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
    double internalRounded = widget.rounded;
    double externalRounded =
        widget.rounded.toDouble() > 0 ? internalRounded + 6 : 0;

    return Container(
      key: const Key('imgy_preview_container'),
      padding: EdgeInsets.all(widget.padding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(externalRounded),
        border: Border.all(
          color: widget.borderColor,
          width: widget.borderWidth,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(internalRounded),
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
