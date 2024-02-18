/// Log levels:
///
/// debug < info < success < warning < error
enum Level {
  all(0),
  debug(10),
  info(20),
  success(25),
  warning(30),
  error(40),
  off(100);

  final int value;

  const Level(this.value);
}
