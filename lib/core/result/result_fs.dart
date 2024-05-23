import 'package:hmi_core/hmi_core.dart' hide Result;
import 'package:hmi_core/hmi_core_result_new.dart';
///
/// Containing either value of type [V] or [Failure] of type [String]
typedef ResultFS<V> = Result<V, Failure<String>>;
