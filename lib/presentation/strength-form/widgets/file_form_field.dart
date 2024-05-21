import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:hmi_core/hmi_core_app_settings.dart';
import 'package:hmi_widgets/hmi_widgets.dart';
import 'package:sss_data_upload_client/core/models/file/file.dart';
import 'package:sss_data_upload_client/presentation/strength-form/widgets/file_input.dart';
/// [FormField] with [FileInput]
class FileFormField<T extends File> extends StatelessWidget {
  final String _label;
  final String? _helperMessage;
  final T? Function(Uint8List?, String?) _buildValue;
  final void Function(T?)? _onValueChanged;
  final void Function(T?)? _onSaved;
  final String? Function(T?)? _validator;
  final T? _initialValue;
  final AutovalidateMode? _autovalidateMode;
  final List<String> _allowedExtensions;
  /// Creates [FileFormField] widget.
  ///
  /// - [label] - label of [FormField];
  /// - [helperMessage] - additional info for [FormField];
  /// - [buildValue] - called to set input value
  /// of [FormField] using [bytes] and [name];
  /// - [onValueChanged] - called when value of [FormField] input changes,
  /// e.g. new file is selected or selection is cleared;
  /// - [onSaved] - onSaved callback for [FormField];
  /// - [validator] - validator for [FormField];
  /// - [initialValue] - initial value for [FileInput];
  /// - [autovalidateMode] - declare [AutovalidateMode] for [FormField];
  /// - [allowedExtensions] - [List] of allowed file extensions for [FileInput]
  /// in [String] format, e.g. ['png', 'jpeg'].
  const FileFormField({
    super.key,
    required String label,
    String? helperMessage,
    required T? Function(Uint8List? bytes, String? name) buildValue,
    void Function(T? newValue)? onValueChanged,
    void Function(T? newValue)? onSaved,
    String? Function(T? value)? validator,
    T? initialValue,
    AutovalidateMode? autovalidateMode,
    required List<String> allowedExtensions,
  })  : _label = label,
        _helperMessage = helperMessage,
        _buildValue = buildValue,
        _onValueChanged = onValueChanged,
        _onSaved = onSaved,
        _validator = validator,
        _initialValue = initialValue,
        _autovalidateMode = autovalidateMode,
        _allowedExtensions = allowedExtensions;
  //
  @override
  Widget build(BuildContext context) {
    final padding = const Setting('padding', factor: 0.5).toDouble;
    return FormField<T>(
      initialValue: _initialValue,
      onSaved: _onSaved,
      validator: _validator,
      autovalidateMode: _autovalidateMode,
      builder: (state) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _FieldDescription(
            label: _label,
            helperMessage: _helperMessage,
          ),
          SizedBox(height: padding),
          FileInput<T>(
            allowedExtensions: _allowedExtensions,
            initialValue: state.value,
            buildValue: _buildValue,
            onValueChanged: (value) {
              state.didChange(value);
              _onValueChanged?.call(value);
            },
          ),
          if (state.hasError)
            Padding(
              padding: EdgeInsets.only(top: padding),
              child: _FieldError(errorMessage: state.errorText ?? ''),
            ),
        ],
      ),
    );
  }
}
///
class _FieldDescription extends StatelessWidget {
  final String label;
  final String? helperMessage;
  ///
  const _FieldDescription({
    required this.label,
    this.helperMessage,
  });
  //
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = Theme.of(context).textTheme;
    final padding = const Setting('padding').toDouble;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(label, style: textTheme.bodyLarge),
        if (helperMessage != null)
          Padding(
            padding: EdgeInsets.only(left: padding),
            child: Tooltip(
              message: helperMessage ?? '',
              child: Icon(
                Icons.info_outline,
                size: 18.0,
                color: theme.colorScheme.primary,
              ),
            ),
          ),
      ],
    );
  }
}
///
class _FieldError extends StatelessWidget {
  final String errorMessage;
  ///
  const _FieldError({required this.errorMessage});
  //
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = Theme.of(context).textTheme;
    return Text(
      errorMessage,
      style: textTheme.bodyMedium?.copyWith(
        color: theme.stateColors.error,
      ),
    );
  }
}
