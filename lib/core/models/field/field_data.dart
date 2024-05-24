import 'dart:async';
import 'package:sss_data_upload_client/core/result/result_fs.dart';
import 'package:sss_data_upload_client/core/models/field/field_type.dart';
import 'package:sss_data_upload_client/core/validation/validator.dart';
///
/// Model that informs about [FormField] data
/// and processes it.
abstract interface class FieldData<T> {
  ///
  /// Field's unique identificator.
  String get id;
  ///
  /// Type of field's data.
  FieldType get type;
  ///
  /// Tag for field's data, used to identify subject of field's data.
  String get tag;
  ///
  /// Field's label (name).
  String get label;
  ///
  /// Field's helper message, can be used to inform user
  /// about some useful information;
  String? get helperMessage;
  ///
  /// Field's validator, used to check field's value
  /// before processing.
  Validator<T>? get validator;
  ///
  /// Processes field data and returns it's string representation.
  Future<ResultFS<String?>> extract(T? value);
}
