import 'package:flutter_midtrans/config/config.dart';
import 'package:logger/logger.dart';

class SimpleLogFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    if (Config.isProd()) return false;
    return true;
  }
}
