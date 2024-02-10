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
  final BorderRadius borderRadius;
  final BorderRadius? borderRadiusInside;
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
    this.borderRadius = const BorderRadius.all(Radius.circular(0)),
    this.borderRadiusInside,
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
  Future<dynamic> openImage(BuildContext context) {
    return showDialog(
      barrierColor: Colors.black.withOpacity(0.8),
      context: context,
      builder: (
        BuildContext context,
      ) {
        ImageStatus imageStatus = ImageStatus.notSaved;
        bool sharingImage = false;
        bool saveCondition = checkFullSrc(widget.fullSrc) && widget.canSave && (imageStatus == ImageStatus.notSaved);
        bool shareCondition = widget.canShare && (sharingImage == false);

        return StatefulBuilder(
          builder: (BuildContext context, StateSetter insideState) {
            final GlobalKey globalKey = GlobalKey();

            Future<Uint8List> captureWidget() async {
              final RenderRepaintBoundary boundary = globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary;
              final ui.Image image = await boundary.toImage(pixelRatio: 3.0);
              final ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
              final Uint8List pngBytes = byteData!.buffer.asUint8List();
              return pngBytes;
            }

            shareImage() async {
              insideState(() {
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

              insideState(() {
                sharingImage = false;
              });
            }

            saveImage() async {
              insideState(() {
                imageStatus = ImageStatus.saving;
              });

              Uint8List bytes = (await NetworkAssetBundle(Uri.parse(widget.fullSrc)).load(widget.fullSrc)).buffer.asUint8List();

              await ImageGallerySaver.saveImage(
                bytes,
                name: randomString(7),
                quality: 100,
              );

              insideState(() {
                imageStatus = ImageStatus.saved;
              });
            }

            return Stack(
              children: [
                Positioned.fill(
                  child: RepaintBoundary(
                    key: globalKey,
                    child: ImgyFullScreen(
                      widget: widget,
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  child: Material(
                    color: Colors.transparent,
                    child: Container(
                      key: const Key('imgy_full_screen_header'),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            key: const Key('imgy_full_screen_close'),
                            color: Colors.red,
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
                              if (sharingImage) const ImgyLoading(),
                              if (shareCondition && !sharingImage)
                                IconButton(
                                  key: const Key('imgy_full_screen_share'),
                                  color: Colors.green,
                                  onPressed: () {
                                    shareImage();
                                  },
                                  icon: const Icon(
                                    Icons.share,
                                    color: Colors.white,
                                  ),
                                ),
                              if (imageStatus == ImageStatus.saving) const ImgyLoading(),
                              if (saveCondition && imageStatus == ImageStatus.notSaved)
                                IconButton(
                                  key: const Key('imgy_full_screen_download'),
                                  color: Colors.green,
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
                                  key: const Key('imgy_full_screen_check'),
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
                  ),
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
