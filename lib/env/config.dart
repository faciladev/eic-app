import 'package:flutter/material.dart';

class Config {
  final String env;
  final bool production;
  final String apiBase;

  Config({this.env, this.production, this.apiBase});
}

class ConfigWrapper extends InheritedWidget {
  const ConfigWrapper({Key key, @required this.config, @required Widget child})
      : assert(config != null),
        assert(child != null),
        super(key: key, child: child);

  final Config config;

  static Config of(BuildContext context) {
    final ConfigWrapper inheritedConfig =
        context.dependOnInheritedWidgetOfExactType(aspect: ConfigWrapper);
    return inheritedConfig.config;
  }

  @override
  bool updateShouldNotify(ConfigWrapper oldWidget) =>
      config != oldWidget.config;
}
