import 'dart:async';
/// Representation of uploaded file
abstract interface class File<T> {
  /// Returns name of [File]
  String name();
  /// Returnts bytes of [File] as [List] if [int]
  List<int> bytes();
  /// Returns file content decoded into [T] format
  extract() => FutureOr<T>;
}
