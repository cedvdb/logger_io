import 'package:logger_io/logger_io.dart';
import 'package:logger/logger.dart' as l;

const iterations = 20;
void main() {
  final dursLoggerIo = <Duration>[];
  dursLoggerIo.add(testLog(logWithLoggerIo));
  dursLoggerIo.add(testLog(logWithLoggerIo));
  dursLoggerIo.add(testLog(logWithLoggerIo));
  dursLoggerIo.add(testLog(logWithLoggerIo));
  dursLoggerIo.add(testLog(logWithLoggerIo));
  dursLoggerIo.add(testLog(logWithLoggerIo));

  final dursOther = <Duration>[];
  dursOther.add(testLog(logWithOther));
  dursOther.add(testLog(logWithOther));
  dursOther.add(testLog(logWithOther));
  dursOther.add(testLog(logWithOther));
  dursOther.add(testLog(logWithOther));
  dursOther.add(testLog(logWithOther));

  final loggerIoDurations =
      dursLoggerIo.skip(1).map((dur) => '${dur.inMilliseconds} ms');
  final otherDurations =
      dursOther.skip(1).map((dur) => '${dur.inMilliseconds} ms');
  print('Durations for logger_io, $iterations iterations: $loggerIoDurations');
  print('Duration for logger, $iterations iterations: $otherDurations');
}

Duration testLog(Function(dynamic i) cb) {
  final sw = Stopwatch();
  sw.start();
  for (int i = 0; i < iterations; i++) {
    cb(i);
  }
  sw.stop();
  return sw.elapsed;
}

final logger = Logger(outputs: [ConsoleOutput()]);
final other = l.Logger(output: l.ConsoleOutput(), filter: MyFilter());
logWithLoggerIo(dynamic i) {
  logger.d(i);
  // logger.i(i);
  // logger.w(i);
  // logger.e(i, stackTrace: StackTrace.current);
}

logWithOther(dynamic i) {
  other.d(i);
  // other.i(i);
  // other.w(i);
  // other.e(i, stackTrace: StackTrace.current);
}

class MyFilter extends l.LogFilter {
  @override
  bool shouldLog(l.LogEvent event) {
    return true;
  }
}
