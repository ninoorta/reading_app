import 'package:intl/intl.dart';

class Time {
  String convertSecondsToDate(int seconds) {
    int hours = 0;
    int days = 0;
    int minutes = 0;
    int seconds = 0;

    int timeDistance;

    timeDistance =
        (DateTime.now().millisecondsSinceEpoch / 1000).ceil() - seconds;

    days = (timeDistance / (60 * 60 * 24)).floor();
    print("days $days");

    if (days >= 24) {
      var date = DateTime.fromMillisecondsSinceEpoch(
          seconds * 1000); // this is milliseconds
      var formattedDate = DateFormat.yMMMd().format(date); // Jun 14, 2021
      print(formattedDate);
      return formattedDate;
    } else {
      if (days == 0) {
        hours = (timeDistance / (60 * 60)).floor();
        print("hours $hours");

        if (hours == 0) {
          minutes = (timeDistance / 60).floor();
          print("minutes $minutes");

          if (minutes < 1) {
            seconds = timeDistance.floor();
            print("seconds $seconds");
          }
        }
      }

      var result = {
        "days": days,
        "hours": hours,
        "minutes": minutes,
        "seconds": seconds
      };
      return result.toString();
    }
  }

  convertTimeToDHMS({required int startTime, required int endTime}) {
    int hours = 0;
    int days = 0;
    int minutes = 0;
    int seconds = 0;

    int timeDistance;

    timeDistance = endTime - startTime;

    days = (timeDistance / (60 * 60 * 24)).floor();
    print("days $days");

    if (days == 0) {
      hours = (timeDistance / (60 * 60)).floor();
      print("hours $hours");

      if (hours == 0) {
        minutes = (timeDistance / 60).floor();
        print("minutes $minutes");

        if (minutes < 1) {
          seconds = timeDistance.floor();
          print("seconds $seconds");
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
