import 'package:isar/isar.dart';

part 'notification_model.g.dart';

@collection
class NotificationModel {
  Id id = Isar.autoIncrement;
  int? notificationId;
  String? notificationType;
  String? notificationCategory;
  DateTime? sendAt;
  String? content;
  bool? isSeen;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? createdBy;
  String? updatedBy;

  NotificationModel({
    this.notificationId,
    this.notificationType,
    this.notificationCategory,
    this.sendAt,
    this.content,
    this.isSeen,
    this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.updatedBy,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      notificationId: json['user_notification_id'],
      notificationType: json['notification_type'],
      notificationCategory: json['notification_category'],
      sendAt: json['send_at'] != null ? DateTime.parse(json['send_at']) : null,
      content: json['content'],
      isSeen: json['isSeen'] ?? false,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
      createdBy: json['created_by'],
      updatedBy: json['updated_by'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_notification_id': notificationId,
      'notification_type': notificationType,
      'notification_category': notificationCategory,
      'send_at': sendAt?.toIso8601String(),
      'content': content,
      'isSeen': isSeen ?? false,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'created_by': createdBy,
      'updated_by': updatedBy,
    };
  }
}
