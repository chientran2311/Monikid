import 'package:logger/logger.dart';

/// Global app logger.

Logger createAppLogger() => Logger(
  filter: DevelopmentFilter(),

  printer: PrettyPrinter(
    methodCount: 0,
    errorMethodCount: 8,
    lineLength: 120,
    colors: true,
    printEmojis: true,
    dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
  ),
);

final logger = createAppLogger();

void printWrapped(String text) {
  final pattern = RegExp('.{1,800}');
  for (final match in pattern.allMatches(text)) {
    final chunk = match.group(0);
    if (chunk == null || chunk.isEmpty) {
      continue;
    }
    logger.d(chunk);
  }
}
