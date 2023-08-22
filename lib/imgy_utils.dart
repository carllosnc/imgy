part of './imgy.dart';

extension ImgyUtils on ImgyState {
  String randomString(int length) {
    const chars = "abcdefghijklmnopqrstuvwxyz0123456789";
    final rnd = Random(DateTime.now().millisecondsSinceEpoch);
    final buf = StringBuffer();

    for (var x = 0; x < length; x++) {
      buf.write(chars[rnd.nextInt(chars.length)]);
    }

    return buf.toString();
  }
}
