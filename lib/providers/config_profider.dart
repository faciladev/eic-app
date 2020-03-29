import 'package:eicapp/env/config.dart';
import 'package:flutter/foundation.dart';

class ConfigProvider extends ChangeNotifier {
  final Config config;
  ConfigProvider({this.config});
}
