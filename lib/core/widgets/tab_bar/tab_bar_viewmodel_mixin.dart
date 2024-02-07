// part of 'tab_bar_notificationwrapper.dart';

// mixin TabBarViewModel on BaseViewModel {
//   bool isScrolling = false;
//   bool isScrollingReverse = false;
//   bool isScrollingForward = false;
//   double? startPoint, endPoint;

//   void onScroll(ScrollNotification notification) {
//     if (notification is ScrollStartNotification) {
//       startPoint = notification.dragDetails?.localPosition.dx;
//     } else if (notification is ScrollUpdateNotification) {
//       final dragX = notification.scrollDelta;
//       if (dragX != null) {
//         if (isScrolling != true) isScrolling = true;
//         if (dragX > 0 && isScrollingForward != true) {
//           isScrollingForward = true;
//         } else if (dragX < 0 && isScrollingReverse != true) {
//           isScrollingReverse = true;
//         }
//       }
//     } else if (notification is ScrollEndNotification) {
//       isScrolling = false;
//       isScrollingReverse = false;
//       isScrollingForward = false;
//     }
//   }

//   ///Instead of notificaton listener can use this function with a controller
//   double getOpacityForTab(TabController? tabController) {
//     final value = tabController!.animation!.value;
//     final tabindex = tabController.index;

//     if (tabindex == 0 && value < 1) {
//       return 1 - value;
//     } else if (value <= tabindex && value > tabindex - 1) {
//       return value - (tabindex - 1);
//     } else if (value > tabindex && value < tabindex + 1) {
//       return (tabindex + 1) - value;
//     }

//     return 0.0;
//   }
// }
