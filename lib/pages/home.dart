import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map data = {};

  @override
  Widget build(BuildContext context) {

    //the below setState function will rebuild this build function and the value of data is also changed
    //writing this ternary condition, so that when it pop back off, we don't want to overwrite the
    //data with initial data(data from loading.dart)(we want to keep with what we just updated with)
    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;//this will return a map of data
    //ModalRoute.of(context).settings.arguments : no explanation(it's the thing we got from loading.dart)
    //print(data);

    //set background
    String bgImage = data['isDaytime'] ? 'day.png' : 'night.png';
    //to output this bg image, we will use container and decoration image
    //box decoration widget gives us a way to apply bg image to fit in the screen
    //right click on padding and select wrap with new widget

    //the top streak is still grey. We will change it according to the time of the day
    Color bgColor = data['isDaytime'] ? Colors.blue : Colors.indigo[700];
    return Scaffold(
      backgroundColor: bgColor,
      /*
      we haven't used an appbar here that's why the 'home screen' text is being hidden
      now use safe area widget
      right click on Text widget and click wrap with widget
      body: Text('home screen'),
       */
      //removing the home screen text and including buttons to navigate among diff pages
      // body: SafeArea(child: Text('home screen')),//moves text down
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/$bgImage'),
              fit: BoxFit.cover,    //it covers the entire container
            )
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0,120.0,0,0),
            child: Column(
              children: [
                FlatButton.icon(
                  onPressed: () async {
                    //below is a function which pushes another page on this screen
                    // (the home screen will exist, just pushing another screen on it)

                    /*since we are popping sth back off, we are not actually rebuilding this widget. So ModalRoute won't get called.
                    Instead we need to find a way to update state inside the widget, with the data we get back from choose_location.dart
                    So, when we pop off and send the info back, we can receive that info over here.
                    We can think it as a async task:going to another screen, choosing the data and coming here with the data
                    make onPressed as async
                     */
                    //since we don't know the datatype, we used dynamic as the return type
                    dynamic result = await Navigator.pushNamed(context, '/location');    //1st param:context object, 2nd: name of route
                                                                                         //the return is a map
                    //now with setState we can update the data
                    setState((){
                      data = {
                        'time':result['time'],
                        'location':result['location'],
                        'isDaytime':result['isDaytime'],
                        'flag':result['flag'],
                      };
                    });
                  },
                  icon: Icon(
                    Icons.edit_location,
                    color: Colors.grey[300],
                  ),
                  label: Text(
                    'Edit Location',
                    style: TextStyle(
                      color: Colors.grey[300],
                    )

                  ),
                ),
                SizedBox(height: 10.0),
                //two things next to each other : flag and location
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      data['location'],
                      style: TextStyle(
                        fontSize: 28.0,
                        letterSpacing: 2.0,
                        color: Colors.white,
                      )
                    ),
                  ],
                ),
                SizedBox(height:20.0),
                Text(
                  data['time'],
                  style: TextStyle(
                    fontSize: 66.0,
                    color: Colors.white,
                )
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
}
