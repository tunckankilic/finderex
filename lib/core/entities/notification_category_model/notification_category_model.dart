import 'package:hive/hive.dart';

part 'notification_category_model.g.dart';

@HiveType(typeId: 0)
class NotificationCategoryModel {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String langCode;

  @HiveField(2)
  final bool isActive;

  @HiveField(3)
  final int catId;

  NotificationCategoryModel({
    required this.name,
    required this.langCode,
    required this.isActive,
    required this.catId,
  });
}
