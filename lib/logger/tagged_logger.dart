import 'package:logger/logger.dart';

class TaggedLogger extends LogPrinter {
  final Object tag;

  TaggedLogger({required this.tag});

  @override
  List<String> log(LogEvent event) {
    final error = event.error == null ? '' : '  ERROR ${event.error}';
    return [
      '[$tag] ${_labelFor(event.level)} ${event.message}$error',
    ];
  }

  String _labelFor(Level level) {
    var prefix = SimplePrinter.levelPrefixes[level]!;
    var color = SimplePrinter.levelColors[level]!;

    return color(prefix);
  }
}
