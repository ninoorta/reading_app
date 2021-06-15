import 'package:intl/intl.dart';

void main() {
  ConvertSecondsToDate();
}

void ConvertSecondsToDate() {
  int timeInMillis = 1623654786;
  var date = DateTime.fromMillisecondsSinceEpoch(timeInMillis * 1000);
  var formattedDate = DateFormat.yMMMd().format(date); // Jun 14, 2021
  print(formattedDate);
}
