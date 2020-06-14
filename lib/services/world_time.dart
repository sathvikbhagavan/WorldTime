import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
class WorldTime {

  String location; //Location name
  String time; //time in that location
  String flag; //url to an asset flag icon
  String url; //Location url for API endpoint
  bool isDayTime; //true of false if day time or not
  String date;
  String month;
  String year;
  String day;

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async {
    try {
      //make a request
      Response response = await get('http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);

      //get Properties from data
      String datetime = data['datetime'];
      DateTime now = DateTime.parse(datetime.substring(0,datetime.length-6));

      isDayTime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now); //set the time property
      month = now.month.toString();
      date = now.day.toString();
      year = now.year.toString();
      List days = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
      day = days[data['day_of_week']];
      print('$day, $date - $month - $year');

    }
    catch (e) {
      print('caught error is $e');
      time = 'could not get time data';
    }
  }
}

