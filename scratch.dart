void main() {
  getDate(1618480018);
}

String getDate(int seconds) {
  var receivedSeconds = seconds * 1000;
  //1618480018000
  var convertedDateString =
      DateTime.fromMillisecondsSinceEpoch(receivedSeconds, isUtc: true)
          .toString();
  var convertedDate =
      DateTime.fromMillisecondsSinceEpoch(receivedSeconds, isUtc: true);
  print(convertedDateString);
  var day = convertedDate.day;
  var month = convertedDate.month;
  var year = convertedDate.year;

  return "$day - $month - $year";
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
