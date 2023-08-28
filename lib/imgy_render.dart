part of './imgy.dart';

extension ImgyRender on ImgyState {
  FadeInImage netWorkImage() {
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

  Image assetImage() {
    return Image.asset(
      key: const Key('imgy_preview_asset'),
      widget.src,
      fit: BoxFit.cover,
      width: widget.width,
      height: widget.height,
    );
  }

  Container previewImage() {
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
          child: checkSrc() ? netWorkImage() : assetImage(),
        ),
      ),
    );
  }

  Widget render() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    if (widget.enableFullScreen) {
      return GestureDetector(
        key: const Key('imgy_gesture_detector'),
        onTap: () {
          openImage(context);
        },
        child: previewImage(),
      );
    }

    return previewImage();
  }
}
