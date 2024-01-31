// import 'package:finderex_notification_app/core/models/base_infinite_viewmodel.dart';

// class FilterExpression<T> {
//   final bool Function(T) filterFunction;

//   FilterExpression(this.filterFunction);
// }

// mixin BaseFilterViewModel<T> on BaseInfiniteViewModel<T> {
//   List<T> get filteredDatas => _applyFilters(datas);

//   List<FilterExpression<T>> _filterExpressions = [];

//   void addFilterExpression(bool Function(T) filter) {
//     _filterExpressions.add(FilterExpression(filter));
//     notifyListeners();
//   }

//   void removeFilterExpression(bool Function(T) filter) {
//     _filterExpressions.removeWhere((expr) => expr.filterFunction == filter);
//     notifyListeners();
//   }

//   List<T> _applyFilters(List<T> originalList) {
//     var filteredList = List<T>.from(originalList);

//     for (var expr in _filterExpressions) {
//       filteredList = filteredList.where(expr.filterFunction).toList();
//     }

//     return filteredList;
//   }
// }
