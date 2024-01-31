
/*
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_local_service.dart';

// **************************************************************************
// HiveBoxServiceGenerator
// **************************************************************************

mixin _$NotificationLocalService {
  Box<Map<dynamic, dynamic>> get box =>
      Hive.box<Map<dynamic, dynamic>>('notificationsBox');

  Future<void> _save(Map<String, dynamic> value) async {
    print('Sacing: $value');
    await box.add(value);
  }

  Map<String, dynamic>? _get(String key) {
    return box.get(key)?.cast<String, dynamic>();
  }

  Future<void> _delete(String key) async {
    await box.delete(key);
  }

  List<Map<String, dynamic>> _getAll() {
    List<Map<String, dynamic>> list =
        box.values.map((e) => e.cast<String, dynamic>()).toList();
    return list;
  }

  List<Map<String, dynamic>> _getDataWithFilter({
    required bool Function(Map<String, dynamic>) filterFunction,
    required int skip,
    required int take,
  }) {
    List<Map<String, dynamic>> list =
        box.values.map((e) => e.cast<String, dynamic>()).toList();
    list.skip(skip).take(take).toList();
    return list;
  }

  Future<void> _deleteAll() async {
    await box.clear();
  }
}
*/