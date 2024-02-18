
A Simple logger that does what a logger should do: send your input messages to a series of outputs.

# Logger io

![logs](https://raw.githubusercontent.com/cedvdb/logger_io/main/logs.png)


# Usage

### Simple

```dart
final logger = Logger();

logger.d('debug message');
logger.i('info message');
logger.w('warning message');
logger.e('error', stackTrace: StackTrace.current);
```

### Multiple outputs

```dart
final logger = Logger(
  outputs: [
    ConsoleOutput(),
    ExampleCrashlyticsOutput(),
  ],
);
```

## Define your output

Just implement the output class. For example, below is an example crashlytics output. 

```dart
class ExampleCrashlyticsOutput implements Output {
  final FirebaseCrashlytics _crashlytics;

  const ExampleCrashlyticsOutput(this._crashlytics);

  @override
  void log({
    required Object? message,
    required Level level,
    required StackTrace? stackTrace,
    required String context,
  }) {
    if (level.value >= Level.error.value) {
      _crashlytics.recordError(message, stackTrace);
    }
  }
}
```

### Change the rendering in the console

The code of console output is very simple, it just uses a formatter and sends 
the result string to the console: 

```dart

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
```

If you wish to change the rendering, just build your own formatter.


### Performance

It is faster than a library like logger because it does not use the stack trace
for every log (only if specified). This results in faster logging when no stack trace is used.

```
Durations for logger_io, 20 debug log (5 times): (1 ms, 2 ms, 2 ms, 1 ms, 2 ms)
Duration for logger, 20 debug log (5 times): (15 ms, 16 ms, 16 ms, 16 ms, 13 ms)
```