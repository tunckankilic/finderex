// // GENERATED CODE - DO NOT MODIFY BY HAND

// part of 'user_local_service.dart';

// // **************************************************************************
// // HiveBoxServiceGenerator
// // **************************************************************************

// mixin _$UserLocalService {
//   Box<String> get box => Hive.box<String>('usersBox');

//   Future<void> _save(String key, Map<String, dynamic> value) async {
//     await box.put(key, json.encode(value));
//   }

//   Map<String, dynamic>? _get(String key) {
//     final value = box.get(key);
//     if (value != null) return json.decode(value);
//     return null;
//   }

//   Future<void> _delete(String key) async {
//     await box.delete(key);
//   }

//   List<Map<String, dynamic>> _getAll() {
//     List<Map<String, dynamic>> list =
//         box.values.map((e) => json.decode(e) as Map<String, dynamic>).toList();
//     return list;
//   }

//   Future<void> _deleteAll() async {
//     await box.clear();
//   }
// }
