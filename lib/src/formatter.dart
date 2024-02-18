import 'dart:convert';

import 'ansi_colors.dart';
import 'level.dart';

abstract interface class Formatter {
  String format({
    required Object? message,
    required Level level,
    required String context,
    required StackTrace? stackTrace,
  });
}

class PrettyFormatter implements Formatter {
  static const _levelPrefix = {
    Level.debug: '[D]',
    Level.info: '[I]',
    Level.success: '[S]',
    Level.warning: '[W]',
    Level.error: '[E]',
  };

  static final _levelColorizer = {
    Level.debug: const AnsiColor.lightGrey(),
    Level.info: const AnsiColor.blue(),
    Level.success: const AnsiColor.green(),
    Level.warning: const AnsiColor.orange(),
    Level.error: const AnsiColor.red(),
  };

  final bool _shouldAddLevelPrefix;
  final bool _shouldColorize;

  const PrettyFormatter({
    bool shouldAddLevelPrefix = true,
    bool shouldColorize = true,
  })  : _shouldAddLevelPrefix = shouldAddLevelPrefix,
        _shouldColorize = shouldColorize;

  @override
  String format({
    required Object? message,
    required Level level,
    required String context,
    required StackTrace? stackTrace,
  }) {
    final levelPrefix = _levelPrefix[level];
    final colorize = _levelColorizer[level];

    String formatted = [
      if (_shouldAddLevelPrefix) levelPrefix,
      if (context.isNotEmpty) '($context)',
      _encodeMessage(message),
    ].join(' ');

    if (stackTrace != null) {
      formatted += '\n$stackTrace';
    }

    if (_shouldColorize && colorize != null) {
      return colorize(formatted);
    }
    return formatted;
  }

  String _encodeMessage(Object? message) {
    if (message is Map || message is Iterable) {
      var encoder = JsonEncoder.withIndent('  ', (msg) => msg.toString());
      return encoder.convert(message);
    } else {
      return message.toString();
    }
  }
}
