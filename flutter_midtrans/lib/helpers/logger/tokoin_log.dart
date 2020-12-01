import 'package:logger/logger.dart';
import 'log_filter.dart';
import 'log_printer.dart';

Logger getLogger() {
  return Logger(
    filter: SimpleLogFilter(),
    printer: SimpleLogPrinter(
      PrettyPrinter(
        methodCount: 2, // number of method calls to be displayed
        errorMethodCount: 8, // number of method calls if stacktrace is provided
        lineLength: 120, // width of the output
        colors: false, // Colorful log messages
        printEmojis: false,
        printTime: false,
      ),
    ),
  );
}

final log = getLogger();
