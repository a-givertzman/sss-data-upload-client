import 'package:hmi_core/hmi_core.dart';
import 'package:hmi_core/hmi_core_result_new.dart';
import 'package:sss_data_upload_client/core/result/result_fs.dart';
import 'validation_case.dart';
///
/// [ValidationCase] to check that value not null
final class ValueRequiredValidationCase<T> implements ValidationCase<T> {
  ///
  /// Creates [ValidationCase] that passes if file not null
  const ValueRequiredValidationCase();
  //
  @override
  ResultFS<void> isSatisfiedBy(value) {
    if (value != null) return const Ok(null);
    return Err(Failure(
      message: const Localized('Required field').v,
      stackTrace: StackTrace.current,
    ));
  }
}
