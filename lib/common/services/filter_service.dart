import 'package:finderex/models/notification_filter.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class FilterService extends GetxController {
  NotificationFilterModel notificationFilterModel = NotificationFilterModel();

  void setCategories(List<Categories> categories) {
    notificationFilterModel.categories = categories;
  }

  clear() {
    notificationFilterModel.categories = Categories.values;
  }
}
