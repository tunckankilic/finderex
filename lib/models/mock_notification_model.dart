class MockNotificationModel {
  final String id;
  final int userId;
  final int notifyType;
  final int notifyCategory;
  final String title;
  final String content;
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
      id: json['id'],
      userId: json['user_id'],
      notifyType: json['notify_type'],
      notifyCategory: json['notify_category'],
      title: json['title'],
      content: json['content'],
      createdAt: json['created_at'],
    );
  }
}
