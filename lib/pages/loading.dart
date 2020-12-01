//initial loading screen....while the data is loading and then redirects to home screen
import 'package:flutter/material.dart';
//importing http package
import 'package:http/http.dart';
//
import 'dart:convert';
import 'package:world_time/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  /*
  //making http packet to make network request to get data
  //for the time being we will just call an api - jsonplaceholder : will get some fake data
  void getData() async {
  //to get data(in this example json data), use get followed by the end point
    Response response = await get('https://jsonplaceholder.typicode.com/todos/1');  //wait for it to get data
                      //and store it in a variable(response object). Response type will help getting the data
                      //we got from end point
    //print(response.body);   //what we got is json strings and not object
                            //we need to convert it to sth so that we can use(type import convert and hit enter)
    Map data = jsonDecode(response.body);//decoded the json string
    print(data);
    print(data['title']);//because now what we got is a map

  }
  */
  /*
  void getTime() async{
    //make the request
    Response  response = await get('http://worldtimeapi.org/api/timezone/Asia/Kolkata');
    Map data = jsonDecode(response.body);
    //print(data);

    //get properties - we want the datetime and the offset
    String  datetime=data['datetime'];
    String offset=data['utc_offset'];//before:+05:30, extracting hrs and minutes below and
    //then we will convert this to int and add it to 'now' as hours and minutes
    //print(datetime);
    //print(offset);

    //handling negative offset and also the one's with 30 min offset
    String offsetHours = offset.substring(0,1) + offset.substring(2,3);
    String offsetMin = offset.substring(0,1) + offset.substring(4,6);

    //create DateTIme object
    DateTime now = DateTime.parse(datetime);    //now is a DateTime object
    now = now.add(Duration(hours: int.parse(offsetHours), minutes: int.parse(offsetMin)));
    print(now);

  }

   */

  //take getTime to a different file inside a custom class, and then that class can be imported to any other file when needed
  //String time = 'Loading';

  void setupWorldTime() async {
    WorldTime instance = WorldTime(location:'Kolkata', flag: 'india.png', url:'Asia/Kolkata');
    /*
    instance.getTime();
    print(instance.time);
    //this will not work, since getTime() is async and the time will get printed before we even get it
     */
    /*
      await instance.getTime();
      print(instance.time);
      //will throw an error since the return type of getTime is not right
      //solution: change void getTime() async to Future<void> getTime() async
      //and make this setupWorldTime an async func i.e. add async to it
     */

    await instance.getTime();
    /*
    print(instance.time);
    //initially time will be loading till the time the function fetches the time
    //setState triggers a rebuild and it updates the time and shows it
    setState(() {
      time = instance.time;
    });
    //once we get the time and it finishes loading, then we should redirect to home screen
    */
    //Navigator.pushNamed(context, '/home');//we pushed the home route on loading route
                                            //instead we can use another function
    //now we don't have location underneath the home route
    Navigator.pushReplacementNamed(context, '/home', arguments: { //used arguments to send the time
                                                                  //data from this file to home file
      'location': instance.location,
      'flag': instance.flag,
      'time': instance.time,
      'isDaytime': instance.isDaytime,
    });
    //arguments is a map


  }


  @override
  void initState() {
    super.initState();
    //getTime();  //copied that file to world_time.dart
    setupWorldTime();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      /*
      body: Padding(
        padding: EdgeInsets.all(50.0),
        //child: Text(time),
        child: Text('Loading'),
      ),
      //making the loading page look better, by importing flutter_spinkit
       */
      body: Center(
        //copied from readme of flutter_spinkit in pub.dev
        child: SpinKitFadingCube(
          color: Colors.white,
          size: 80.0,
        ),
      )

    );


  }
}