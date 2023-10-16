import 'package:flutter/material.dart';
import './imgy.dart';
import './imgy_utils.dart';

class ImgyFullScreenWebImage extends StatelessWidget {
  const ImgyFullScreenWebImage({
    super.key,
    required this.widget,
  });

  final Imgy widget;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      widget.fullSrc,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }

        return const Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: Colors.white,
          ),
        );
      },
    );
  }
}

class ImgyFullScreen extends StatelessWidget {
  const ImgyFullScreen({
    super.key,
    required this.widget,
  });

  final Imgy widget;

  @override
  Widget build(BuildContext context) {
    final GlobalKey globalKey = GlobalKey();

    return Positioned.fill(
      child: Stack(
        key: const Key('imgy_full_screen_container'),
        children: [
          Center(
            child: Container(
              key: const Key('imgy_full_screen_image'),
              constraints: const BoxConstraints(
                maxWidth: 500,
              ),
              child: InteractiveViewer(
                clipBehavior: Clip.none,
                maxScale: 5.0,
                minScale: 1.0,
                child: GestureDetector(
                  key: const Key('imgy_full_screen_gesture'),
                  onTap: () {
                    if (widget.tapImageToClose) {
                      Navigator.of(context).pop();
                    }
                  },
                  child: RepaintBoundary(
                    key: globalKey,
                    child: Container(
                      color: Colors.transparent,
                      child: checkFullSrc(widget.fullSrc)
                          ? ImgyFullScreenWebImage(widget: widget)
                          : Image.asset(widget.fullSrc, fit: BoxFit.cover),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
