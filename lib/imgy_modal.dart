part of './imgy.dart';

extension ImgyModal on ImgyState {
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
}
