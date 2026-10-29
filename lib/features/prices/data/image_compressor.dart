import 'dart:typed_data';

import 'package:flutter_image_compress/flutter_image_compress.dart';

const maxPhotoBytes = 200 * 1024;

/// Re-encodes with falling quality (then falling size) until the result is
/// under [maxBytes]. [encode] is injected so this is testable without a plugin.
Future<Uint8List?> compressUnder(
  Future<Uint8List> Function(int quality, int maxSide) encode, {
  int maxBytes = maxPhotoBytes,
}) async {
  for (final side in [1280, 1024, 800, 640]) {
    for (final quality in [80, 65, 50, 35]) {
      final bytes = await encode(quality, side);
      if (bytes.length <= maxBytes) return bytes;
    }
  }
  return null; // give up: caller submits without the photo
}

Future<Uint8List?> compressPhoto(String path) => compressUnder(
  (quality, side) async =>
      await FlutterImageCompress.compressWithFile(
        path,
        minWidth: side,
        minHeight: side,
        quality: quality,
        format: CompressFormat.jpeg,
      ) ??
      (throw StateError('Image compression failed')),
);
