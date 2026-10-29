import 'package:firebase_storage/firebase_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'image_compressor.dart';

part 'photo_uploader.g.dart';

@Riverpod(keepAlive: true)
PhotoUploader photoUploader(Ref ref) => PhotoUploader(FirebaseStorage.instance);

class PhotoUploader {
  PhotoUploader(this._storage);
  final FirebaseStorage _storage;

  /// Compresses to under 200 KB and uploads. Returns the download URL, or
  /// `null` if anything fails (Storage not enabled, no signal, photo too big
  /// to shrink): the price is still worth submitting without the photo.
  Future<String?> uploadPriceTag(String localPath, String uid) async {
    try {
      final bytes = await compressPhoto(localPath);
      if (bytes == null) return null;
      final ref = _storage.ref(
        'priceTags/$uid/${DateTime.now().millisecondsSinceEpoch}.jpg',
      );
      await ref
          .putData(bytes, SettableMetadata(contentType: 'image/jpeg'))
          .timeout(const Duration(seconds: 20));
      return await ref.getDownloadURL();
    } catch (_) {
      return null;
    }
  }
}
