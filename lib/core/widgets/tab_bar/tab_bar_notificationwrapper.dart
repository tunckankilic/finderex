// import 'package:flutter/material.dart';
// import 'package:stacked/stacked.dart';
// part 'tab_bar_viewmodel_mixin.dart';

// class TabBarNotificationWrapper<T extends BaseViewModel>
//     extends ViewModelWidget<T> {
//   final Widget child;
//   const TabBarNotificationWrapper({
//     Key? key,
//     required this.child,
//   });

//   Widget build(
//     BuildContext context,
//     dynamic viewModel,
//   ) {
//     viewModel as TabBarViewModel;
//     return NotificationListener(
//       onNotification: (notification) {
//         if (notification is ScrollNotification) {
//           viewModel.onScroll(notification);
//         }
//         return false;
//       },
//       child: child,
//     );
//   }
// }
