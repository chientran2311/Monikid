/// Where evidence images are stored.
///
/// - [cloudinary]: uploaded to Cloudinary, `image_url` holds the delivery URL.
/// - [local]: saved to the device documents directory, `image_url` is null
///   until the user syncs the image up to Cloudinary.
enum ImageStorageMode {
  cloudinary,
  local;

  /// Maps a stored key back to a mode, defaulting to [cloudinary] for unknown
  /// or missing values (backward-compatible with legacy data without a mode).
  static ImageStorageMode fromKey(String? key) {
    return ImageStorageMode.values.firstWhere(
      (m) => m.name == key,
      orElse: () => ImageStorageMode.cloudinary,
    );
  }
}
