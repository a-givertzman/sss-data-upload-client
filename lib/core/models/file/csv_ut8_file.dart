import 'dart:typed_data';
import 'dart:convert';
import 'package:hmi_core/hmi_core.dart' hide Result;
import 'package:hmi_core/hmi_core_result_new.dart';
import 'package:sss_data_upload_client/core/models/file/file_uploaded.dart';
///
/// Representation of uploaded [FileUploaded]
/// with csv format and utf8 character encoding
final class CsvUtf8File implements FileUploaded<String> {
  final String _name;
  final Uint8List _bytes;
  ///
  /// Creates [FileUploaded] with csv format and utf8 character encoding
  /// using passed [name] and [bytes]
  const CsvUtf8File({
    required String name,
    required Uint8List bytes,
  })  : _name = name,
        _bytes = bytes;
  //
  @override
  String name() => _name;
  //
  @override
  Uint8List bytes() => _bytes;
  ///
  /// Returns [CsvUtf8File] content as text
  @override
  Result<String, Failure<String>> extract() {
    try {
      return Ok(utf8.decode(_bytes.toList()));
    } on FormatException {
      return Err(Failure(
        message: const Localized('Wrong file format or charset encoding').v,
        stackTrace: StackTrace.current,
      ));
    }
  }
}
