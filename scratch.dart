import 'package:intl/intl.dart';

void main() {
  ConvertSecondsToDate();

  getDateTime();
}

void ConvertSecondsToDate() {
  double from = 1622244730; // this is second
  double to = 1623983164;
  int timeInMillis = 1623654786;
  double timeSpace = (from - to) / (60);
  print("time space $timeSpace");
  print("time space ${from - to}");

  var nowInSeconds = DateTime.now().millisecondsSinceEpoch / 1000;
  print("now $nowInSeconds");

  var date = DateTime.fromMillisecondsSinceEpoch(
      timeInMillis * 1000); // this is milisecond
  var formattedDate = DateFormat.yMMMd().format(date); // Jun 14, 2021
  print(formattedDate);
}

void getDateTime() {
  int hours;
  int days;
  int minutes;
  int seconds;

  var nowInSeconds = ((DateTime.now().millisecondsSinceEpoch / 1000).ceil());
  print("now in seconds: $nowInSeconds");

  int to = 1624004336;

  int space = nowInSeconds - to;

  print("space $space");

  days = (space / (60 * 60 * 24)).floor();
  print("days $days");

  if (days == 0) {
    hours = (space / (60 * 60)).floor();
    print("hours $hours");

    if (hours == 0) {
      minutes = (space / 60).floor();
      print("minutes $minutes");

      if (minutes < 1) {
        seconds = space.floor();
        print("seconds $seconds");
      }
    }
  }
}
