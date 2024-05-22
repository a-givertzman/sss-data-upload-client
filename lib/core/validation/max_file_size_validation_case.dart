import 'package:hmi_core/hmi_core.dart' hide Result;
import 'package:hmi_core/hmi_core_result_new.dart';
import 'package:sss_data_upload_client/core/models/file/file_uploaded.dart';
import 'validation_case.dart';
///
/// [ValidationCase] to check file size with upper limit
final class MaxFileSizeValidationCase implements ValidationCase<FileUploaded> {
  final int _maxFileSize;
  ///
  /// Creates [ValidationCase] that passes if size of file
  /// less or equal to [maxFileSize]
  ///
  /// - [maxFileSize] - upper limit for file size in bytes.
  const MaxFileSizeValidationCase({required int maxFileSize})
      : assert(maxFileSize > 0),
        _maxFileSize = maxFileSize;
  //
  @override
  Result<void, Failure<String>> isSatisfiedBy(value) {
    if (value == null) {
      return const Ok(null);
    }
    if (value.bytes().length <= _maxFileSize) {
      return const Ok(null);
    }
    return Err(Failure(
      message: const Localized('File size too large').v,
      stackTrace: StackTrace.current,
    ));
  }
}
