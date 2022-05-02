import 'package:logger/logger.dart';

var log = Logger(
  printer: LogConfig(),
);

class LogConfig extends LogPrinter {
  @override
  List<String> log(LogEvent event) {
    final color = PrettyPrinter.levelColors[event.level];
    final emoji = PrettyPrinter.levelEmojis[event.level];
    final message = event.message;
    return [color!('$emoji: $message')];
  }
}
