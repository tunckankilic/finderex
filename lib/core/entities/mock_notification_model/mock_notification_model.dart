import 'package:hive/hive.dart';

part 'mock_notification_model.g.dart';

@HiveType(typeId: 0)
class MockNotificationModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final int userId;

  @HiveField(2)
  final int notifyType;

  @HiveField(3)
  final int notifyCategory;

  @HiveField(4)
  final String title;

  @HiveField(5)
  final String content;

  @HiveField(6)
  final int createdAt;

  MockNotificationModel({
    required this.id,
    required this.userId,
    required this.notifyType,
    required this.notifyCategory,
    required this.title,
    required this.content,
    required this.createdAt,
  });

  factory MockNotificationModel.fromJson(Map<String, dynamic> json) {
    return MockNotificationModel(
      id: json['id'] as String,
      userId: json['userId'] as int,
      notifyType: json['notifyType'] as int,
      notifyCategory: json['notifyCategory'] as int,
      title: json['title'] as String,
      content: json['content'] as String,
      createdAt: json['createdAt'] as int,
    );
  }
}
