import 'package:flutter/foundation.dart';
import 'package:hmi_core/hmi_core.dart' hide Result;
import 'package:hmi_core/hmi_core_result_new.dart';
import 'package:sss_data_upload_client/core/models/file/file_uploaded.dart';
import 'validation_case.dart';
///
/// [ValidationCase] to check file character encoding
final class Utf8FileEncodingValidationCase
    implements ValidationCase<FileUploaded> {
  ///
  ///
  const Utf8FileEncodingValidationCase();
  //
  @override
  Result<void, Failure<String>> isSatisfiedBy(FileUploaded? value) {
    if (value == null) {
      return const Ok(null);
    }
    final bytes = value.bytes();
    if (bytes.length > 3) {
      // https://en.wikipedia.org/wiki/Byte_order_mark
      final byteOrderMark = bytes.sublist(0, 3);
      if (listEquals(byteOrderMark, [239, 187, 191])) return const Ok(null);
    }
    return Err(Failure(
      message: 'Character encoding of file should be UTF-8',
      stackTrace: StackTrace.current,
    ));
  }
}
