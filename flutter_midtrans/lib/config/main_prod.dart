import 'package:flutter_midtrans/config/config.dart';

void main() {
  Config.setEnvironment(Environment.Prod);
  mainDelegate();
}
