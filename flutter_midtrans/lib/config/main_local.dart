import 'package:flutter_midtrans/config/config.dart';
import 'package:flutter_midtrans/main_configured.dart';

void main() {
  Config.setEnvironment(Environment.Local);
  mainDelegate();
}
