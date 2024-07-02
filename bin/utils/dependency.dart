import 'dart:io';

import 'package:yaml/yaml.dart';

import 'exceptions.dart';

const dependenciesId = 'dependencies';
const nameId = 'name';
const configId = 'go_mvp';

String introMessage(String version) => '''
  ════════════════════════════════════════════
     📘 Go MVP (v $version)                
  ════════════════════════════════════════════
  ''';

Map<String, dynamic> loadDependenciesFile() {
  final File file = File("pubspec.yaml");
  final String yamlString = file.readAsStringSync();
  // ignore: always_specify_types
  final Map yamlMap = loadYaml(yamlString);

  if (yamlMap[dependenciesId] is! Map) {
    stderr.writeln(
      const NoConfigFoundException(
        'Check your config file pubspec.yaml has a `$dependenciesId` section',
      ),
    );
    exit(1);
  }

  final Map<String, dynamic> config = <String, dynamic>{};
  for (MapEntry<dynamic, dynamic> entry in yamlMap[dependenciesId].entries) {
    config[entry.key] = entry.value;
  }

  return config;
}

String loadId() {
  final File file = File("pubspec.yaml");
  final String yamlString = file.readAsStringSync();
  // ignore: always_specify_types
  final Map yamlMap = loadYaml(yamlString);

  return yamlMap[nameId];
}

Map<String, dynamic> loadConfigFile() {
  final File file = File("pubspec.yaml");
  final String yamlString = file.readAsStringSync();
  // ignore: always_specify_types
  final Map yamlMap = loadYaml(yamlString);

  if (yamlMap[configId] is! Map) {
    stderr.writeln(
      const NoConfigFoundException(
        'Check your config file pubspec.yaml has a `$configId` section',
      ),
    );
    exit(1);
  }

  final Map<String, dynamic> config = <String, dynamic>{};
  for (MapEntry<dynamic, dynamic> entry in yamlMap[configId].entries) {
    config[entry.key] = entry.value;
  }

  return config;
}
