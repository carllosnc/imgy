part of './imgy.dart';

extension ImgyPreview on ImgyState {
  Positioned imagePreview() {
    return Positioned.fill(
      child: Stack(
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
                    child: FadeInImage(
                      image: NetworkImage(
                        widget.fullSrc,
                      ),
                      placeholder: MemoryImage(kTransparentImage),
                      fit: BoxFit.cover,
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
