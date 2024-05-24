import 'package:hmi_core/hmi_core_result_new.dart';
import 'package:sss_data_upload_client/core/validation/validation_case.dart';
///
/// Can be used to check value for some conditions
class Validator<T> {
  final List<ValidationCase<T>> _cases;
  ///
  /// Creates [Validator]
  ///
  /// - [cases] - [List] of [ValidationCase] that are used to
  /// validate value.
  const Validator({
    required List<ValidationCase<T>> cases,
  }) : _cases = cases;
  ///
  /// Returns [null] if value passed all [ValidationCase],
  /// otherwise returns error message from
  /// first failed [ValidationCase]
  String? editFieldValidator(T? value) {
    for (final validationCase in _cases) {
      final result = validationCase.isSatisfiedBy(value);
      if (result case Err(:final error)) {
        return error.message;
      }
    }
    return null;
  }
}
