import 'package:logger_io/src/formatter.dart';
import 'package:logger_io/src/level.dart';

abstract class Output {
  void log({
    required Object? message,
    required Level level,
    required StackTrace? stackTrace,
    required String context,
  });
}

class ConsoleOutput implements Output {
  final Formatter _formatter;

  const ConsoleOutput({
    Formatter formatter = const PrettyFormatter(),
  }) : _formatter = formatter;

  @override
  void log({
    required Object? message,
    required Level level,
    required StackTrace? stackTrace,
    required String context,
  }) {
    final formatted = _formatter.format(
      message: message,
      level: level,
      context: context,
      stackTrace: stackTrace,
    );
    print(formatted);
  }
}
