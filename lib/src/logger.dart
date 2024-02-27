import 'package:logger_io/src/level.dart';

import 'output.dart';

/// Logger that logs to a each output it has been constructed with.
///
/// Examples:
/// ```dart
/// final logger = Logger();
///
/// logger.d('debug message');
/// logger.i('info message');
/// logger.s('success message');
/// logger.w('warning message');
/// logger.e('error');
///
/// // change the logging outputs depending on the environmnet
///
/// final env = 'dev'
/// final advancedLogger = Logger(
///   outputs: [
///     if (env == 'dev') ConsoleOutput(),
///     if (env == 'prod') MyCrashlyticsOutput()
/// ])
/// ```
class Logger {
  final Iterable<Output> _outputs;
  final Level _level;
  final String _context;

  const Logger({
    Level level = Level.all,
    Iterable<Output> outputs = const [ConsoleOutput()],
    String context = '',
  })  : _outputs = outputs,
        _level = level,
        _context = context;

  /// Logs with debug level
  void d(Object? message) {
    _log(Level.debug, message);
  }

  /// Logs with info level
  void i(Object? message) {
    _log(Level.info, message);
  }

  /// Logs with success level
  void s(Object? message) {
    _log(Level.success, message);
  }

  /// Logs with warning level
  void w(Object? message) {
    _log(Level.warning, message);
  }

  /// Logs with error level
  void e(Object? e, {StackTrace? stackTrace}) {
    _log(Level.error, e, stackTrace: stackTrace);
  }

  void _log(Level level, Object? message, {StackTrace? stackTrace}) {
    if (level.value < _level.value) {
      return;
    }
    for (final output in _outputs) {
      output.log(
        message: message,
        level: level,
        stackTrace: stackTrace,
        context: _context,
      );
    }
  }
}
