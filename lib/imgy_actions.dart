part of './imgy.dart';

extension ImgyActions on ImgyState {
  shareImage() async {
    _setState(() {
      sharingImage = true;
    });

    var result = await captureWidget();

    await Share.shareXFiles([
      XFile.fromData(
        result,
        name: randomString(10),
        mimeType: 'image/png',
      )
    ]);

    _setState(() {
      sharingImage = false;
    });
  }

  Future<Uint8List> captureWidget() async {
    final RenderRepaintBoundary boundary =
        globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary;

    final ui.Image image = await boundary.toImage(pixelRatio: 3.0);

    final ByteData? byteData =
        await image.toByteData(format: ui.ImageByteFormat.png);

    final Uint8List pngBytes = byteData!.buffer.asUint8List();

    return pngBytes;
  }

  saveImage() async {
    _setState(() {
      imageStatus = ImageStatus.saving;
    });

    var result = await captureWidget();

    await ImageGallerySaver.saveImage(
      result,
      name: randomString(7),
      quality: 100,
    );

    _setState(() {
      imageStatus = ImageStatus.saved;
    });
  }
}
