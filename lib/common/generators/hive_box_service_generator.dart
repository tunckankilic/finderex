import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'hive_annotation.dart';

Builder hiveBoxServiceBuilder(BuilderOptions options) => SharedPartBuilder(
      [HiveBoxServiceGenerator()],
      'hiveBox',
      additionalOutputExtensions: [
        '.hivebox\$${'file'.hashCode.toRadixString(32)}.dart'
      ],
    );

class HiveBoxServiceGenerator extends GeneratorForAnnotation<HiveService> {
  @override
  FutureOr<String> generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) async {
    if (element is! ClassElement) {
      throw InvalidGenerationSourceError(
          'HiveService annotation can only be applied to a class.',
          element: element,
          todo: 'Remove the HiveService annotation from this element.');
    }

    final className = element.name;
    final fileName = buildStep.inputId.pathSegments.last;
    final boxName = annotation.read('boxName').stringValue;

    return '''

    mixin _\$$className {
      Box<String> get box => Hive.box<String>('$boxName');
       
        Future<void> _save(String key, Map<String, dynamic> value) async {
          await box.put(key, json.encode(value));
        }

        Map<String, dynamic>? _get(String key) {
          final value = box.get(key);
          if(value != null)
            return json.decode(value);
          return null;
        }

        Future<void> _delete(String key) async {
          await box.delete(key);
        }

        List<Map<String, dynamic>> _getAll() {
          List<Map<String, dynamic>> list =
              box.values.map((e) => json.decode(e) as Map<String, dynamic>).toList();
          return list;
        }

        Future<void> _deleteAll() async {
          await box.clear();
        }
    }
    ''';
  }
}
