import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

@LazySingleton()
class TimeConverterService {
  String getTimeDifference(DateTime createdTime) {
    final now = DateTime.now();
    final difference = now.difference(createdTime);
    if (difference.inDays >= 7) {
      return DateFormat('dd/MM/yy').format(createdTime);
    } else if (difference.inDays >= 2) {
      final weekday = DateFormat('EEEE').format(createdTime);
      return weekday;
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inHours >= 1) {
      return '${difference.inHours} hours ago';
    } else if (difference.inMinutes >= 1) {
      return '${difference.inMinutes} min ago';
    } else if (difference.inSeconds >= 1) {
      return '${difference.inSeconds} seconds ago';
    } else {
      return 'Just now';
    }
  }

  String getTimeDifferenceGroupSeperator(
    DateTime? currentDate,
    DateTime? nextDate,
    DateTime? previousDate,
    String? previousDay,
  ) {
    if (currentDate == null) return '';
    final diffNow = DateTime.now().difference(currentDate);

    final differenceWithNextElement =
        nextDate == null ? null : currentDate.difference(nextDate);
    final differenceWithPreviousElement =
        previousDate == null ? null : currentDate.difference(previousDate);

    String returnDay = '';

    if (diffNow.inDays == 0) {
      returnDay = 'Today';
    } else if (diffNow.inDays == 1) {
      returnDay = 'Yesterday';
    } else {
      // Calculate the difference in days between the current date and the notification date
      int daysDifference = diffNow.inDays.abs();

      // Determine the string representation of the date
      if (daysDifference < 7) {
        returnDay = '$daysDifference days ago';
      } else if (daysDifference < 30) {
        int weeksDifference = (daysDifference / 7).floor();
        returnDay =
            '$weeksDifference week${weeksDifference == 1 ? '' : 's'} ago';
      } else {
        int monthsDifference = (daysDifference / 30).floor();
        returnDay =
            '$monthsDifference month${monthsDifference == 1 ? '' : 's'} ago';
      }
    }

    if (previousDay == returnDay) {
      returnDay = '';
    } else if (differenceWithNextElement != null) {
      if (differenceWithNextElement.inDays == 0) {
        returnDay = '';
      }
    }

    return returnDay;

    /*if (returnDay.isEmpty) {
      return SizedBox.shrink();
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Text(
          returnDay,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }*/
  }
}
