import 'dart:async';

import 'package:build/build.dart';
import 'package:glob/glob.dart';

Builder exportsBuilder(BuilderOptions options) => ExportsBuilder();

class ExportsBuilder implements Builder {
  @override
  final buildExtensions = const {
    r'$lib$': ['injection/hive_service_initializer.dart']
  };

  @override
  Future<void> build(BuildStep buildStep) async {
    final exports = buildStep.findAssets(Glob('**/*.hiveexports'));

    List<String> imports = [];
    List<String> exportedCode = [];
    await for (var exportLibrary in exports) {
      imports.add(
        'import \'${exportLibrary.changeExtension('.dart').uri}\';',
      );
      exportedCode.add(
        await buildStep.readAsString(exportLibrary),
      );
    }

    final content = [
      '//Automatically Generated for Hive Initialization',
      'import \'package:hive_flutter/hive_flutter.dart\';',
      'import \'package:injectable/injectable.dart\';',
      'import \'package:finderex_notification_app/injection/injection_container.dart\';',
      ...imports,
      '''

class HiveServiceInitializer {
  static final HiveServiceInitializer _singleton = HiveServiceInitializer._internal();

  factory HiveServiceInitializer() {
    return _singleton;
  }

  HiveServiceInitializer._internal();
        
  Future<void> openAllBoxes() async {
  ''',
      ...exportedCode,
      '''
  }

}''',
      /*      '''
          await Hive.openBox<Map<String, dynamic>>('$boxNameValue');
          locator.registerLazySingleton<${annotationElement.element?.name}>(() => ${annotationElement.element?.name}());
        '''
          'export \'${exportLibrary.changeExtension('.dart').uri}\' '
          'show ${await buildStep.readAsString(exportLibrary)};'*/
    ];
    if (content.isNotEmpty) {
      buildStep.writeAsString(
          AssetId(buildStep.inputId.package,
              'lib/injection/hive_service_initializer.dart'),
          content.join('\n'));
    }
  }
}
