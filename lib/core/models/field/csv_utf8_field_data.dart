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
  final String _label;
  final String? _helperMessage;
  final Validator<CsvUtf8File>? _validator;
  ///
  /// Creates [FieldData] using passed values
  ///
  /// - [label];
  /// - [helperMessage];
  /// - [validator].
  const CsvUtf8FieldData({
    required String label,
    String? helperMessage,
    Validator<CsvUtf8File>? validator,
  })  : _label = label,
        _helperMessage = helperMessage,
        _validator = validator;
  //
  @override
  String label() => _label;
  //
  @override
  String? helperMessage() => _helperMessage;
  //
  @override
  FieldType type() => FieldType.csvUtf8;
  //
  @override
  Validator<CsvUtf8File>? validator() => _validator;
  //
  @override
  Future<ResultFS<Map<String, dynamic>>> asMap(
    CsvUtf8File? value,
  ) async {
    if (value == null) {
      return Ok({
        'label': label(),
        'type': 'csv',
        'body': null,
      });
    }
    return switch (await value.extract()) {
      Ok(value: final text) => Ok({
          'label': label(),
          'type': 'csv',
          'body': text,
        }),
      Err(:final error) => Err(error),
    };
  }
}
