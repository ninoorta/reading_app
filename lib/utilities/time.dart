class Time {
  String getDate(int seconds) {
    var receivedSeconds = seconds * 1000;
    var convertedDateString =
        DateTime.fromMillisecondsSinceEpoch(receivedSeconds, isUtc: true)
            .toString();
    var convertedDate =
        DateTime.fromMillisecondsSinceEpoch(receivedSeconds, isUtc: true);
    var day =
        convertedDate.day >= 10 ? convertedDate.day : "0${convertedDate.day}";
    var month = convertedDate.month >= 10
        ? convertedDate.month
        : "0${convertedDate.month}";
    var year = convertedDate.year;

    return "$day - $month - $year";
  }

  convertTimeToDHMS({required int startTime, required int endTime}) {
    int hours = 0;
    int days = 0;
    int minutes = 0;
    int seconds = 0;

    int timeDistance;

    timeDistance = endTime - startTime;

    days = (timeDistance / (60 * 60 * 24)).floor();
    // print("days $days");

    if (days == 0) {
      hours = (timeDistance / (60 * 60)).floor();
      // print("hours $hours");

      if (hours == 0) {
        minutes = (timeDistance / 60).floor();
        // print("minutes $minutes");

        if (minutes < 1) {
          seconds = timeDistance.floor();
          // print("seconds $seconds");
        }
      }
    }
    return {
      "days": days,
      "hours": hours,
      "minutes": minutes,
      "seconds": seconds
    };
  }
}
