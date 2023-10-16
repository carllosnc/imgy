import 'package:flutter/material.dart';
import './imgy.dart';
import './imgy_utils.dart';

class ImgyLoading extends StatelessWidget {
  const ImgyLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
}

class ImgyHeader extends StatelessWidget {
  final ImageStatus status;
  final bool sharing;
  final Function onSave;
  final Function onShare;

  const ImgyHeader({
    super.key,
    required this.widget,
    required this.status,
    required this.sharing,
    required this.onSave,
    required this.onShare,
  });

  final Imgy widget;

  @override
  Widget build(BuildContext context) {
    bool saveCondition = checkFullSrc(widget.fullSrc) &&
        widget.canSave &&
        (status == ImageStatus.notSaved);

    bool shareCondition = widget.canShare && (sharing == false);

    return Positioned(
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
                  if (sharing == true) const ImgyLoading(),
                  if (shareCondition)
                    IconButton(
                      key: const Key('imgy_full_screen_share'),
                      color: Colors.green,
                      onPressed: () {
                        onShare();
                      },
                      icon: const Icon(
                        Icons.share,
                        color: Colors.white,
                      ),
                    ),
                  if (status == ImageStatus.saving) const ImgyLoading(),
                  if (saveCondition)
                    IconButton(
                      key: const Key('imgy_full_screen_download'),
                      color: Colors.green,
                      onPressed: () {
                        onSave();
                      },
                      icon: const Icon(
                        Icons.download,
                        color: Colors.white,
                      ),
                    ),
                  if (status == ImageStatus.saved)
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
    );
  }
}
