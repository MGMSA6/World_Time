import 'dart:convert';

import 'package:http/http.dart';

class WorldTime {
  late String location; // location name for the UI
  late String time; // the time in that location
  late String flag; // url to the asset flag icon
  late String url = ''; // location url for api endpoint

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    try {
      // http network request
      var uri = Uri.parse('http://worldtimeapi.org/api/timezone/$url');
      Response response = await get(uri);
      Map data = jsonDecode(response.body);

      String datetime = data['datetime'];
      String utc_offset = data['utc_offset'].substring(1, 3);

      // create DateTime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(utc_offset)));

      // set the time property
      time = now.toString();
    } catch (e) {
      print('caught error: $e');
      time = 'could not get time data';
    }
  }
}
