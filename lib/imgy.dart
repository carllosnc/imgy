library imgy;

import 'dart:ui' as ui;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

part './imgy_actions.dart';
part './imgy_utils.dart';
part 'imgy_full_screen.dart';
part './imgy_header.dart';
part './imgy_modal.dart';
part './imgy_render.dart';
part './imgy_extras.dart';

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
  });

  @override
  State<Imgy> createState() => ImgyState();
}

class ImgyState extends State<Imgy> {
  final GlobalKey globalKey = GlobalKey();

  ImageStatus imageStatus = ImageStatus.notSaved;
  bool sharingImage = false;
  late StateSetter _setState;

  @override
  Widget build(BuildContext context) {
    return render();
  }
}
