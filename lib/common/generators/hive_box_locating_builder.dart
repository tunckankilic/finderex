import 'dart:async';

import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'hive_annotation.dart';

Builder exportLocatingBuilder(BuilderOptions options) =>
    ExportLocatingBuilder();

class ExportLocatingBuilder implements Builder {
  @override
  final buildExtensions = const {
    '.dart': ['.hiveexports']
  };

  @override
  Future<void> build(BuildStep buildStep) async {
    final resolver = buildStep.resolver;
    if (!await resolver.isLibrary(buildStep.inputId)) return;
    final lib = LibraryReader(await buildStep.inputLibrary);
    final exportAnnotation = const TypeChecker.fromRuntime(HiveService);
    final annotated = [
      for (var member in lib.annotatedWith(exportAnnotation))
        '''
          await Hive.openBox<String>('${member.annotation.read('boxName').stringValue}');
          locator.registerLazySingleton<${member.element.name}>(() => ${member.element.name}());
        ''',
    ];
    if (annotated.isNotEmpty) {
      buildStep.writeAsString(buildStep.inputId.changeExtension('.hiveexports'),
          annotated.join(','));
    }
  }
}
