part of './imgy.dart';

extension ImgyHeader on ImgyState {
  Positioned imageHeader(BuildContext context) {
    return Positioned(
      key: const Key('imgy_full_screen_header'),
      top: 0,
      left: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              key: const Key('imgy_full_screen_close_button'),
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
                if (widget.canShare && (sharingImage == false))
                  IconButton(
                    key: const Key('imgy_full_screen_share_button'),
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
                if (widget.canSave && (imageStatus == ImageStatus.notSaved))
                  IconButton(
                    key: const Key('imgy_full_screen_download_button'),
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
                    key: const Key('imgy_full_screen_saved_icon'),
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
}
