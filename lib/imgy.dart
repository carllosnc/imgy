library imgy;

import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:imgy/imgy_full_screen.dart';
import 'package:share_plus/share_plus.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

import 'imgy_utils.dart';
import 'imgy_description.dart';
import 'imgy_thumbnail.dart';
import 'imgy_header.dart';

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
  final bool canShare;
  final bool canSave;
  final bool enableFullScreen;
  final bool tapImageToClose;

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
    this.canShare = true,
    this.canSave = true,
    this.enableFullScreen = false,
    this.tapImageToClose = true,
  });

  @override
  State<Imgy> createState() => ImgyState();
}

class ImgyState extends State<Imgy> {
  final GlobalKey globalKey = GlobalKey();

  ImageStatus imageStatus = ImageStatus.notSaved;
  bool sharingImage = false;

  shareImage() async {
    setState(() {
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

    setState(() {
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
    setState(() {
      imageStatus = ImageStatus.saving;
    });

    Uint8List bytes = (await NetworkAssetBundle(Uri.parse(widget.fullSrc))
            .load(widget.fullSrc))
        .buffer
        .asUint8List();

    await ImageGallerySaver.saveImage(
      bytes,
      name: randomString(7),
      quality: 100,
    );

    setState(() {
      imageStatus = ImageStatus.saved;
    });
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
            return Stack(
              children: [
                ImgyFullScreen(widget: widget),
                ImgyHeader(
                  widget: widget,
                  status: imageStatus,
                  sharing: sharingImage,
                  onSave: saveImage,
                  onShare: shareImage,
                ),
                if (widget.description != null)
                  ImgyDescription(
                    context: context,
                    widget: widget,
                  ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
        child: ImgyThumbnail(widget: widget),
      );
    }

    return ImgyThumbnail(widget: widget);
  }
}
