part of './imgy.dart';

extension ImgyRender on ImgyState {
  Widget render() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    double internalRounded = widget.rounded;
    double externalRounded =
        widget.rounded.toDouble() > 0 ? internalRounded + 6 : 0;

    return GestureDetector(
      key: const Key('imgy_preview_container'),
      onTap: () {
        if (widget.enableFullScreen) {
          openImage(context);
        }
      },
      child: Container(
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
            child: FadeInImage(
              key: const Key('imgy_preview_image'),
              fadeInDuration: const Duration(milliseconds: 300),
              placeholder: MemoryImage(kTransparentImage),
              fit: BoxFit.cover,
              width: widget.width,
              height: widget.height,
              image: NetworkImage(
                widget.src,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
