library imgy;

import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

enum ImageStatus {
  saving,
  saved,
  notSaved,
}

class Imgy extends StatefulWidget {
  final String src;
  final String fullSrc;
  final String? description;
  final Color borderColor;
  final Color placeholderColor;
  final double padding;
  final double width;
  final double height;
  final double borderWidth;
  final double rounded;

  const Imgy({
    super.key,
    required this.src,
    required this.fullSrc,
    this.borderColor = Colors.transparent,
    this.placeholderColor = Colors.transparent,
    this.description,
    this.rounded = 0,
    this.padding = 0,
    this.borderWidth = 0,
    this.width = 100,
    this.height = 100,
  });

  @override
  State<Imgy> createState() => _ImgyState();
}

class _ImgyState extends State<Imgy> {
  final GlobalKey globalKey = GlobalKey();

  ImageStatus imageStatus = ImageStatus.notSaved;
  bool sharingImage = false;
  late StateSetter _setState;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    double internalRounded = widget.rounded;
    double externalRounded =
        widget.rounded.toDouble() > 0 ? internalRounded + 6 : 0;

    return GestureDetector(
      onTap: () {
        openImage(context);
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
              fadeInDuration: const Duration(milliseconds: 400),
              placeholder: MemoryImage(kTransparentImage),
              fit: BoxFit.cover,
              width: widget.width,
              height: widget.width,
              image: NetworkImage(
                widget.src,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> openImage(BuildContext context) {
    return showDialog(
      barrierColor: Colors.black.withOpacity(0.8),
      context: context,
      builder: (
        BuildContext context,
      ) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            _setState = setState;

            return Stack(
              children: [
                imagePreview(),
                imageHeader(context),
                if (widget.description != null) imageDescription(context),
              ],
            );
          },
        );
      },
    );
  }

  Positioned imageDescription(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(30, 20, 20, 30),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.black,
            ],
          ),
        ),
        child: Text(
          widget.description!,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Positioned imageHeader(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.close,
                color: Colors.white,
              ),
            ),
            Wrap(
              spacing: 10,
              children: [
                if (sharingImage == true) loading(),
                if (sharingImage == false)
                  IconButton(
                    onPressed: () {
                      shareImage();
                    },
                    icon: const Icon(
                      Icons.share,
                      color: Colors.white,
                    ),
                  ),
                if (imageStatus == ImageStatus.saving) loading(),
                if (imageStatus == ImageStatus.notSaved)
                  IconButton(
                    onPressed: () {
                      saveImage();
                    },
                    icon: const Icon(
                      Icons.download,
                      color: Colors.white,
                    ),
                  ),
                if (imageStatus == ImageStatus.saved)
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  IconButton loading() {
    return IconButton(
      onPressed: () {},
      icon: const SizedBox(
        width: 18,
        height: 18,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: Colors.white,
        ),
      ),
    );
  }

  Positioned imagePreview() {
    return Positioned.fill(
      child: Center(
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
              child: Image.network(
                widget.src,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }

  String randomString(int length) {
    const chars = "abcdefghijklmnopqrstuvwxyz0123456789";
    final rnd = Random(DateTime.now().millisecondsSinceEpoch);
    final buf = StringBuffer();

    for (var x = 0; x < length; x++) {
      buf.write(chars[rnd.nextInt(chars.length)]);
    }

    return buf.toString();
  }

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
