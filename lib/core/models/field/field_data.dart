import 'dart:async';
import 'package:sss_data_upload_client/core/result/result_fs.dart';
import 'package:sss_data_upload_client/core/models/field/field_type.dart';
import 'package:sss_data_upload_client/core/validation/validator.dart';
///
/// Model that informs about [FormField] data
/// and processes it.
abstract interface class FieldData<T> {
  ///
  /// Returns field's label.
  String label();
  ///
  /// Returns field's helper message.
  String? helperMessage();
  ///
  /// Returns field's validator.
  Validator<T>? validator();
  ///
  /// Returns type of field's data.
  FieldType type();
  ///
  /// Processes field data and returns it's json representation.
  Future<ResultFS<Map<String, dynamic>>> asMap(T? value);
}
