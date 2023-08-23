part of './imgy.dart';

extension ImgyHeader on ImgyState {
  Positioned imageHeader(BuildContext context) {
    bool saveCondition = checkFullSrc() &&
        widget.canSave &&
        (imageStatus == ImageStatus.notSaved);

    bool shareCondition = widget.canShare && (sharingImage == false);

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
                  if (sharingImage == true) loading(),
                  if (shareCondition)
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
                  if (imageStatus == ImageStatus.saving) loading(),
                  if (saveCondition)
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
    );
  }
}
