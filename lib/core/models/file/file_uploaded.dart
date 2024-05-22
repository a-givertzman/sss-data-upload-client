import 'dart:async';
import 'dart:typed_data';
import 'package:hmi_core/hmi_core.dart' hide Result;
import 'package:hmi_core/hmi_core_result_new.dart';
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
  FutureOr<Result<T, Failure<String>>> extract();
}
