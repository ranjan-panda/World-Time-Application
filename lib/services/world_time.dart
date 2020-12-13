import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
class WorldTime{
  //when we create instance of this class ,we will pass location, flag, url and time will be found
  String location; //location name for the UI
  String time; // time in that location
  String flag; // flag next to the location, url to the flag for the location
               //url to an asset flag icon
  String url; //location url for the api endpoint
  bool isDaytime;  //true or false if daytime or not

  //named constructor
  WorldTime({this.location, this.flag, this.url});
  Future<void> getTime() async{

    try {
      Response  response = await get('http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);

      String  datetime=data['datetime'];
      String offset=data['utc_offset'];

      String offsetHours = offset.substring(0,1) + offset.substring(2,3);
      String offsetMin = offset.substring(0,1) + offset.substring(4,6);
      //create DateTime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offsetHours), minutes: int.parse(offsetMin)));

      //set the time property
      //time= now.toString();

      isDaytime = now.hour > 6 && now.hour < 20 ? true : false;
      //to format date and time in nicer way, import the intl package and add it in pubspec.yaml as well
      time = DateFormat.jm().format(now);//no explanation for this line
    }
    catch(e) {//e is the error object based on the error
      print('Caught error: $e');
      time ='could not get time data';
    }


  }
 }

 //we might pass a url for the endpoint that is not valid,hence use try and catch