import 'package:hmi_core/hmi_core.dart' hide Result;
import 'package:hmi_core/hmi_core_result_new.dart';
///
/// Can be used to check [T] value for some condtion.
abstract interface class ValidationCase<T> {
  ///
  /// Returns [Ok] if the value is satisfied, and [Err] otherwise.
  Result<void, Failure<String>> isSatisfiedBy(T? value);
}
