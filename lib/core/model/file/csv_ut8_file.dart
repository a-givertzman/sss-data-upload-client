import 'dart:typed_data';
import 'dart:convert';
import 'package:sss_data_upload_client/core/model/file/file.dart';
/// Representation of uploaded [File]
/// with csv format and utf8 character encoding
final class CsvUtf8File implements File<String> {
  final String _name;
  final Uint8List _bytes;
  /// Creates [File] with csv format and utf8 character encoding
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
  List<int> bytes() => _bytes.toList();
  /// Returns [CsvUtf8File] content as text
  @override
  extract() {
    return utf8.decode(_bytes);
  }
}
