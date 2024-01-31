// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:get/get_rx/src/rx_types/rx_types.dart';
// import 'package:stacked/stacked.dart';

// abstract class BaseInfiniteViewModel<T> extends ReactiveViewModel {
//   late List<T> datas;
//   RxBool isLoading = false.obs;
//   late bool isIniting;
//   bool isFinished = false;

//   int pageIndex = 0;
//   int pageCount = 20;

//   Future<void> init() async {
//     datas = [];
//     isIniting = true;

//     await getData();
//     increasePageNumber();

//     isIniting = false;
//     notifyListeners();
//   }

//   Future<void> refresh() async {
//     isIniting = true;
//     isFinished = false;
//     clearData();
//     resetPageNumber();
//     notifyListeners();

//     await getData();
//     increasePageNumber();

//     isIniting = false;
//     notifyListeners();
//     return;
//   }

//   Future<void> nextPage() async {
//     if (isFinished) return;
//     setLoading(true);

//     await getData();
//     increasePageNumber();

//     setLoading(false);
//   }

//   void setLoading(bool newValue) {
//     isLoading(newValue);
//   }

//   void resetPageNumber() {
//     pageIndex = 0;
//   }

//   void increasePageNumber() {
//     pageIndex += 1;
//   }

//   void clearData() {
//     datas.clear();
//   }

//   @mustCallSuper
//   Future<void> getData();
// }
