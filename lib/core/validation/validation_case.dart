import 'package:hmi_core/hmi_core_result_new.dart';
import 'package:sss_data_upload_client/core/result/result_fs.dart';
///
/// Can be used to check [T] value for some condtion.
abstract interface class ValidationCase<T> {
  ///
  /// Returns [Ok] if the value is satisfied, and [Err] otherwise.
  ResultFS<void> isSatisfiedBy(T? value);
}
