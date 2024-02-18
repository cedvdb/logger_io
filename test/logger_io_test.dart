import 'package:logger_io/logger_io.dart';
import 'package:test/test.dart';

class TestOutput implements Output {
  Object? lastMessage;
  @override
  void log(
      {required Object? message,
      required Level level,
      required StackTrace? stackTrace,
      required String context}) {
    lastMessage = message;
  }
}

void main() {
  group('Logger', () {
    test('should log for levels above or equal the current level', () {
      final output = TestOutput();
      final logger = Logger(level: Level.warning, outputs: [output]);
      logger.d('debug');
      expect(output.lastMessage, isNull);
      logger.i('info');
      expect(output.lastMessage, isNull);
      logger.w('warning');
      expect(output.lastMessage, contains('warning'));
      logger.w('error');
      expect(output.lastMessage, contains('error'));
    });

    test('should log to all outputs', () {
      final consoleOutput = TestOutput();
      final crashlyticsOutput = TestOutput();
      final sentryOutput = TestOutput();

      final logger = Logger(outputs: [
        consoleOutput,
        crashlyticsOutput,
        sentryOutput,
      ]);
      logger.i('info');
      expect(consoleOutput.lastMessage, contains('info'));
      expect(crashlyticsOutput.lastMessage, contains('info'));
      expect(sentryOutput.lastMessage, contains('info'));
    });
  });
}
