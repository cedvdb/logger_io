/// This class handles colorizing of terminal output.
class AnsiColor {
  /// ANSI Control Sequence Introducer, signals the terminal for new settings.
  static const _ansiEsc = '\x1B[';

  /// Reset all colors and options for current SGRs to terminal defaults.
  static const _ansiDefault = '${_ansiEsc}0m';

  final String? _ansiColor;

  const AnsiColor(int color) : _ansiColor = '${_ansiEsc}38;5;${color}m';

  const AnsiColor.lightGrey() : this(15);
  const AnsiColor.blue() : this(12);
  const AnsiColor.orange() : this(214);
  const AnsiColor.red() : this(9);
  const AnsiColor.green() : this(10);

  String call(String msg) {
    return '$_ansiColor$msg$_ansiDefault';
  }
}
