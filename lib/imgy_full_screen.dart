part of './imgy.dart';

extension ImgyFullScreen on ImgyState {
  FadeInImage fullScreenNetWorkImage() {
    return FadeInImage(
      fadeInDuration: const Duration(milliseconds: 300),
      image: NetworkImage(
        widget.fullSrc,
      ),
      placeholder: MemoryImage(kTransparentImage),
      fit: BoxFit.cover,
    );
  }

  fullScreenAssetImage() {
    return Image.asset(
      widget.fullSrc,
      fit: BoxFit.cover,
    );
  }

  Positioned imagePreview() {
    return Positioned.fill(
      child: Stack(
        key: const Key('imgy_full_screen_container'),
        children: [
          const Positioned.fill(
            child: Center(
              child: SizedBox(
                width: 25,
                height: 25,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              ),
            ),
          ),
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
                child: RepaintBoundary(
                  key: globalKey,
                  child: Container(
                    color: Colors.black,
                    child: checkFullSrc()
                        ? fullScreenNetWorkImage()
                        : fullScreenAssetImage(),
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
