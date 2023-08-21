library imgy;

//import 'dart:math';

import 'package:flutter/material.dart';
//import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
// import 'dart:ui' as ui;
import 'package:transparent_image/transparent_image.dart';

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
              fadeInDuration: const Duration(milliseconds: 200),
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
      builder: (BuildContext context) {
        return Stack(
          children: [
            imagePreview(),
            imageHeader(context),
            if (widget.description != null) imageDescription(context),
          ],
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
                IconButton(
                  onPressed: () {
                    //shareImage();
                  },
                  icon: const Icon(
                    Icons.share_outlined,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.download_outlined,
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

  // String randomString(int length) {
  //   const chars = "abcdefghijklmnopqrstuvwxyz0123456789";
  //   final rnd = Random(DateTime.now().millisecondsSinceEpoch);
  //   final buf = StringBuffer();

  //   for (var x = 0; x < length; x++) {
  //     buf.write(chars[rnd.nextInt(chars.length)]);
  //   }

  //   return buf.toString();
  // }

  // shareImage() async {
  //   var result = await captureWidget();

  //   Share.shareXFiles([
  //     XFile.fromData(
  //       result,
  //       name: randomString(10),
  //       mimeType: 'image/png',
  //     )
  //   ]);
  // }

  // Future<Uint8List> captureWidget() async {
  //   final RenderRepaintBoundary boundary =
  //       globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary;

  //   final ui.Image image = await boundary.toImage(pixelRatio: 3.0);

  //   final ByteData? byteData =
  //       await image.toByteData(format: ui.ImageByteFormat.png);

  //   final Uint8List pngBytes = byteData!.buffer.asUint8List();

  //   return pngBytes;
  // }
}
