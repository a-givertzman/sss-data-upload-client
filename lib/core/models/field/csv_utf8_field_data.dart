import 'dart:async';
import 'package:hmi_core/hmi_core_result_new.dart';
import 'package:sss_data_upload_client/core/result/result_fs.dart';
import 'package:sss_data_upload_client/core/models/field/field_data.dart';
import 'package:sss_data_upload_client/core/models/field/field_type.dart';
import 'package:sss_data_upload_client/core/models/file/csv_ut8_file.dart';
import 'package:sss_data_upload_client/core/validation/validator.dart';
///
/// [FieldData] for [CsvUtf8File].
final class CsvUtf8FieldData implements FieldData<CsvUtf8File> {
  @override
  final String id;
  @override
  final FieldType type = FieldType.csvUtf8;
  @override
  final String tag;
  @override
  final String label;
  @override
  final String? helperMessage;
  @override
  final Validator<CsvUtf8File>? validator;
  ///
  /// Creates [FieldData] using passed values
  ///
  /// - [id] - field's unique identificator;
  /// - [label] - field's label;
  /// - [helperMessage] - field's helper message, can be used to inform user
  /// about some useful information;
  /// - [validator] - field's validator, used to check field's value
  /// before processing.
  const CsvUtf8FieldData({
    required this.id,
    required this.tag,
    required this.label,
    this.helperMessage,
    this.validator,
  });
  //
  @override
  Future<ResultFS<String?>> extract(CsvUtf8File? value) async {
    if (value == null) return const Ok(null);
    return value.extract();
  }
}
