import 'package:logger_io/logger_io.dart';

void main() {
  final logger = Logger();
  logger.d('debug message');
  logger.i('info message');
  logger.w('warning message');
  logger.e('error', stackTrace: StackTrace.current);

  // change the logging outputs depending on the environmnet
  final env = 'dev';
  final envLogger = Logger(
    context: env,
    outputs: [
      if (env == 'dev') ConsoleOutput(),
      MyCrashlyticsOutput(),
    ],
  );
  envLogger.i('info message');
}

class MyCrashlyticsOutput implements Output {
  @override
  void log({
    required Object? message,
    required Level level,
    required StackTrace? stackTrace,
    required String context,
  }) {
    // call crashlytics if level should be sent here
  }
}
