import 'package:hmi_core/hmi_core.dart';
import 'package:hmi_core/hmi_core_result_new.dart';
import 'package:sss_data_upload_client/core/models/field/field_data.dart';
import 'package:sss_data_upload_client/core/models/field/field_type.dart';
import 'package:sss_data_upload_client/core/result/result_fs.dart';
///
/// Transform [FieldData] to its json representation
class FieldJson<T> {
  final FieldData<T> _fieldData;
  ///
  /// Creates [FieldJson] that can be used to
  /// transform [FieldData] to its json representaion.
  ///
  /// - [fieldData] - target [FieldData] object.
  const FieldJson({
    required FieldData<T> fieldData,
  }) : _fieldData = fieldData;
  ///
  /// Returns json representation for [FieldData] and its [value] as [Map]
  Future<ResultFS<Map<String, dynamic>>> asMap(T? value) async {
    return switch (await _fieldData.extract(value)) {
      Ok(value: final body) => Ok({
          'id': _fieldData.id,
          'type': switch (_fieldData.type) {
            FieldType.csvUtf8 => 'csv',
          },
          'tag': _fieldData.tag,
          'body': body,
        }),
      Err(:final error) => Err(Failure(
          message: '${_fieldData.label}: $error',
          stackTrace: StackTrace.current,
        )),
    };
  }
}
