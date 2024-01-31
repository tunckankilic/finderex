import 'dart:developer';

import 'package:finderex/models/notification_filter.dart';
import 'package:finderex/models/notification_model.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class LocalNotificationService {
  Future<void> init() async {
    final isar = await _getFileObjectNotification();

    isar!.notificationModels
        .where()
        .sortByCreatedAtDesc()
        .limit(1)
        .watch()
        .listen((event) {
      if (LocalNotificationService.onNewElementAdded != null)
        LocalNotificationService.onNewElementAdded!(event);
    });
  }

  static void Function(List<NotificationModel>)? onNewElementAdded;

  Future<bool> insert(NotificationModel notificationModel) async {
    try {
      final isar = await _getFileObjectNotification();

      await isar!.writeTxn(() async {
        await isar.notificationModels.put(notificationModel);
      });

      return true;
    } catch (e) {
      Future.error(e);
    }

    return false;
  }

  Future<bool> update(NotificationModel notificationModel) async {
    try {
      final isar = await _getFileObjectNotification();

      await isar!.writeTxn(() async {
        await isar.notificationModels.put(notificationModel);
      });

      return true;
    } catch (e) {
      Future.error(e);
    }

    return false;
  }

  Future<bool> delete(NotificationModel notificationModel) async {
    try {
      final isar = await _getFileObjectNotification();
      await isar!.writeTxn(() async {
        final success =
            await isar.notificationModels.delete(notificationModel.id);
        log('Recipe deleted: $success');
      });
      return true;
    } catch (e) {
      Future.error(e);
    }

    return false;
  }

  Future<bool> deleteAll() async {
    try {
      final isar = await _getFileObjectNotification();
      await isar!.notificationModels.clear();

      return true;
    } catch (e) {
      Future.error(e);
    }

    return false;
  }

  Future<List<NotificationModel>> getAll(int offset, int limit) async {
    try {
      final isar = await _getFileObjectNotification();
      final notifications = await isar!.notificationModels
          .where()
          .sortByCreatedAtDesc()
          .offset(offset)
          .limit(limit)
          .findAll();

      return notifications;
    } catch (e) {
      Future.error(e);
    }

    return [];
  }

  Future<List<NotificationModel>> getAllFilter(
    int offset,
    int limit,
    NotificationFilterModel filters,
  ) async {
    try {
      final isar = await _getFileObjectNotification();

      QueryBuilder<NotificationModel, NotificationModel, QAfterFilterCondition>
          queryBuilder = QueryBuilder.apply(
              isar!.notificationModels.where().filter(), (query) {
        return query;
      });

      if (filters.searchQuery?.isNotEmpty == true) {
        for (var searchQuery in filters.searchQuery!) {
          queryBuilder = queryBuilder
              .or()
              .contentContains(searchQuery, caseSensitive: false);
        }
      } else {
        for (var category in filters.categories) {
          queryBuilder = queryBuilder
              .or()
              .contentContains(category.name, caseSensitive: false);
        }
      }

      final notifications = await queryBuilder
          .sortByCreatedAtDesc()
          .offset(offset)
          .limit(limit)
          .findAll();

      return notifications;
    } catch (e) {
      Future.error(e);
    }

    return [];
  }

  static Isar? localIsar;
  static Future<Isar?> _getFileObjectNotification() async {
    if (localIsar != null) return localIsar;
    try {
      final databasePathRoot = await getApplicationDocumentsDirectory();
      final dataBasePath = databasePathRoot.path;

      final isar =
          await Isar.open([NotificationModelSchema], directory: dataBasePath);
      localIsar = isar;
      return isar;
    } catch (e) {
      Future.error(e);
    }

    return null;
  }
}
