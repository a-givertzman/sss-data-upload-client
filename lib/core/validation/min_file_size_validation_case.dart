import 'package:hmi_core/hmi_core.dart';
import 'package:hmi_core/hmi_core_result_new.dart';
import 'package:sss_data_upload_client/core/result/result_fs.dart';
import 'package:sss_data_upload_client/core/models/file/file_uploaded.dart';
import 'validation_case.dart';
///
/// [ValidationCase] to check file size with lower limit
final class MinFileSizeValidationCase implements ValidationCase<FileUploaded> {
  final int _minFileSize;
  ///
  /// Creates [ValidationCase] that passes if size of file
  /// greater or equal to [minFileSize]
  ///
  /// - [minFileSize] - lower limit for file size in bytes.
  const MinFileSizeValidationCase({required int minFileSize})
      : assert(minFileSize > 0),
        _minFileSize = minFileSize;
  //
  @override
  ResultFS<void> isSatisfiedBy(value) {
    if (value == null) {
      return const Ok(null);
    }
    if (value.bytes().length >= _minFileSize) {
      return const Ok(null);
    }
    return Err(Failure(
      message: const Localized('File size too small').v,
      stackTrace: StackTrace.current,
    ));
  }
}
