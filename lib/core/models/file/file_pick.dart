import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:hmi_core/hmi_core.dart' hide Result;
import 'package:hmi_core/hmi_core_result_new.dart';
import 'package:sss_data_upload_client/core/models/file/file_uploaded.dart';
///
/// Interface for calling system file picker
/// and uploading selected files
class FilePick<T extends FileUploaded> {
  final bool _allowMultiple;
  final List<String> _allowedExtension;
  final T Function(Uint8List, String) _buildValue;
  ///
  /// Creates [FilePick] that can be used to
  /// upload files through system file picker
  ///
  /// - [allowMultiple] - if `true` allows to select multiple files;
  /// - [allowedExtension] - [List] of allowed file extensions for [FileInput]
  /// in [String] format, e.g. `['png', 'jpeg']`;
  /// - [buildValue] - called to get [FileUploaded] using [bytes] and [name].
  const FilePick({
    required bool allowMultiple,
    required List<String> allowedExtension,
    required T Function(Uint8List bytes, String name) buildValue,
  })  : _allowMultiple = allowMultiple,
        _allowedExtension = allowedExtension,
        _buildValue = buildValue;
  ///
  /// Retrieves the file(s) from the underlying platform
  Future<Result<List<T>?, Failure<String>>> pick() async {
    return FilePicker.platform
        .pickFiles(
          allowMultiple: _allowMultiple,
          allowedExtensions: _allowedExtension,
          type: FileType.custom,
          withData: true,
        )
        .then<Result<List<T>?, Failure<String>>>(
          (pickResult) => Ok(pickResult?.files.map((file) {
            final (bytes, name) = (file.bytes, file.name);
            if (bytes == null) {
              throw Failure(
                message: "Can't upload file ${file.name}",
                stackTrace: StackTrace.current,
              );
            }
            return _buildValue(bytes, name);
          }).toList()),
        )
        .onError(
          (error, stackTrace) => Err(
            Failure(message: '$error', stackTrace: stackTrace),
          ),
        );
  }
}
