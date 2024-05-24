import 'dart:async';
import 'dart:typed_data';
import 'package:sss_data_upload_client/core/result/result_fs.dart';
///
/// Representation of uploaded file
abstract interface class FileUploaded<T> {
  ///
  /// Returns name of [FileUploaded]
  String name();
  ///
  /// Returns bytes of [FileUploaded]
  Uint8List bytes();
  ///
  /// Returns file content decoded into [T] format
  FutureOr<ResultFS<T>> extract();
}
