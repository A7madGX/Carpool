import 'package:intl/intl.dart';

DateTime strToDate(String strDate) {
  DateFormat format = DateFormat('dd/MM/yyyy - hh:mma');
  DateTime parsedDateTime = format.parse(strDate);
  return (parsedDateTime);
}

String dateToString(DateTime date) {
  return DateFormat('dd/MM/yyyy - hh:mma').format(date);
}

String calcTimeDiff(DateTime date1, DateTime date2) {
  final difference = (date1.hour == 17)
      ? date1.difference(date2.add(const Duration(hours: 4, minutes: 30)))
      : date1.difference(date2.add(const Duration(hours: 9, minutes: 30)));
  if (difference.isNegative) {
    return 'Closed';
  }

  if (difference.inHours < 1) {
    if (difference.inMinutes == 1) return '${difference.inMinutes} min';
    return '${difference.inMinutes} mins';
  }
  if (difference.inDays < 1) {
    if (difference.inHours == 1) return '${difference.inHours} hr';
    return '${difference.inHours} hrs';
  }
  if (difference.inDays == 1) return '${difference.inDays} day';
  return '${difference.inDays} days';
}

String getInitialTripDate({required bool fromASU}) {
  String date = '';
  if (fromASU) {
    date = (DateTime.now().hour < 13)
        ? dateToString(DateTime.now().copyWith(hour: 17, minute: 30))
        : dateToString(DateTime.now().copyWith(hour: 17, minute: 30).add(const Duration(days: 1)));
  } else {
    date = (DateTime.now().hour < 22)
        ? dateToString(DateTime.now().copyWith(hour: 7, minute: 30).add(const Duration(days: 1)))
        : dateToString(DateTime.now().copyWith(hour: 7, minute: 30).add(const Duration(days: 2)));
  }
  return date;
}

String getTripDate({required bool fromASU, required DateTime dateTime}) {
  String date = '';
  if (fromASU) {
    date = dateToString(dateTime.copyWith(hour: 17, minute: 30));
  } else {
    date = dateToString(dateTime.copyWith(hour: 7, minute: 30));
  }
  return date;
}
