import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hmi_core/hmi_core.dart';
import 'package:hmi_core/hmi_core_app_settings.dart';
import 'package:sss_data_upload_client/core/models/file/file_uploaded.dart';
///
/// Input widget for file selection
class FileInput<T extends FileUploaded> extends StatefulWidget {
  final T? Function(Uint8List?, String?) _buildValue;
  final void Function(T?)? _onValueChanged;
  final T? _initialValue;
  final List<String> _allowedExtensions;
  ///
  /// Creates [FileInput] widget.
  ///
  /// - [buildValue] - called to set [FileInput] value using [bytes] and [name];
  /// - [onValueChanged] - called when value of [FileInput] changes,
  /// e.g. new file is selected or selection is cleared;
  /// - [initialValue] - initial value for [FileInput];
  /// - [allowedExtensions] - [List] of allowed file extensions for [FileInput]
  /// in [String] format, e.g. ['png', 'jpeg'].
  const FileInput({
    super.key,
    required T? Function(Uint8List? bytes, String? name) buildValue,
    void Function(T? value)? onValueChanged,
    T? initialValue,
    List<String> allowedExtensions = const [],
  })  : _buildValue = buildValue,
        _onValueChanged = onValueChanged,
        _initialValue = initialValue,
        _allowedExtensions = allowedExtensions;
  //
  @override
  State<FileInput<T>> createState() => _FileInputState<T>(
        buildValue: _buildValue,
        onValueChanged: _onValueChanged,
        initialValue: _initialValue,
        allowedExtensions: _allowedExtensions,
      );
}
///
class _FileInputState<T extends FileUploaded> extends State<FileInput<T>> {
  final T? Function(Uint8List?, String?) _buildValue;
  final void Function(T?)? _onValueChanged;
  final T? _initialValue;
  final List<String>? _allowedExtensions;
  T? _value;
  ///
  _FileInputState({
    required T? Function(Uint8List? bytes, String? name) buildValue,
    void Function(T? value)? onValueChanged,
    T? initialValue,
    List<String>? allowedExtensions,
  })  : _buildValue = buildValue,
        _onValueChanged = onValueChanged,
        _initialValue = initialValue,
        _allowedExtensions = allowedExtensions;
  //
  @override
  void initState() {
    _value = _initialValue;
    super.initState();
  }
  //
  @override
  Widget build(BuildContext context) {
    final padding = const Setting('padding', factor: 0.5).toDouble;
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.centerLeft,
            child: _FilePreview(
              file: _value,
              onDelete: () => _handleValueChange(null),
            ),
          ),
        ),
        SizedBox(width: padding),
        FilledButton.icon(
          icon: const Icon(Icons.file_upload_outlined),
          label: Text(const Localized('Browse file').v),
          onPressed: _handleFilePick,
        ),
      ],
    );
  }
  ///
  void _handleFilePick() async {
    final pickerResult = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      withData: true,
      allowedExtensions: _allowedExtensions,
    );
    if (pickerResult == null) return;
    _handleValueChange(_buildValue(
      pickerResult.files.first.bytes,
      pickerResult.files.first.name,
    ));
  }
  ///
  void _handleValueChange(T? newValue) {
    setState(() {
      _value = newValue;
    });
    _onValueChanged?.call(newValue);
  }
}
///
class _FilePreview<T extends FileUploaded> extends StatelessWidget {
  final T? file;
  final void Function() onDelete;
  ///
  const _FilePreview({
    required this.file,
    required this.onDelete,
  });
  //
  @override
  Widget build(BuildContext context) {
    const iconSize = 18.0;
    return file != null
        ? InputChip(
            avatar:
                const Icon(Icons.insert_drive_file_outlined, size: iconSize),
            label: Text(file?.name() ?? ''),
            deleteIcon: const Icon(Icons.close, size: iconSize),
            onDeleted: onDelete,
          )
        : Text(const Localized('No file selected').v);
  }
}
