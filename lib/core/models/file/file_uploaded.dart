import 'dart:typed_data';
///
/// Representation of uploaded file
abstract interface class FileUploaded<T> {
  ///
  /// Returns name of [FileUploaded]
  String name();
  ///
  /// Returnts bytes of [FileUploaded]
  Uint8List bytes();
  ///
  /// Returns file content decoded into [T] format
  T extract();
}
