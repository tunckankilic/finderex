import 'notification_model.dart';

class NotificationFilter {
  final String name;
  final bool Function(NotificationModel) filterFunction;

  NotificationFilter(this.name, this.filterFunction);
}

enum Categories {
  CRYPTO,
  BIST100,
}

class NotificationFilterModel {
  List<String>? searchQuery;
  List<Categories> categories = Categories.values;

  late bool isContainsCrypto = categories.contains(Categories.CRYPTO);
  late bool isContainsBist100 = categories.contains(Categories.BIST100);
}
