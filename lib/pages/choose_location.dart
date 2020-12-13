import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';

class ChooseLocation extends StatefulWidget {
  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}
/*
class _ChooseLocationState extends State<ChooseLocation> {

  //type init and press enter
  //through this we are overriding the original initState function of the State class

  /*add a state like(for ex: counter integer) and change it, so that we can see that
  every time we call the setState(when the button is pressed)
   and change the state, we trigger the build function to rerun
   */
  int counter=0;
  @override
  void initState() {
    //removed android studio function named to do which was automatically generated with init
    //the to do tasks show up in the to do tab(besides run tab)
    super.initState();      //this is the original inherited init function
                            //write the code that is to be executed, after running init function(i.e. after writing super.initState())
    print('initState function ran');/* when you go away from the page we take the widget off and get rid of
                                       state object and when you again go to the location page, the state object
                                       gets recreated and both the lines will be displayed in console
                                     */

  }
  @override
  Widget build(BuildContext context) {
    print('build function ran');
    return Scaffold(
      backgroundColor: Colors.grey[200],
      //we have pushed the location page onto home.Now to go back we need a back option.
      // This is readily available in appbar
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text('Choose a Location'),
        centerTitle: true,
        elevation: 0,//remove the drop shadow-> makes it flat on the page
      ),
      //body: Text('choose location screen'),
      body: RaisedButton(
        onPressed: () {
          setState(() {
            counter+=1;
          });
        },
        child: Text('counter is  $counter'),

      )
    );
  }
}


//it will become tall stack of pushed routes on one another after a time and difficult to
// manage as even home page can be stacked into the tree many times(redundant pages stacked)
*/

//Asynchronous code - starts the request but it doesn't finish straightway(takes 1 or 2 seconds
//to grab the data), in the meantime our code continues compiling the rest of the code
class _ChooseLocationState extends State<ChooseLocation> {
/*
  //func for asynchronous code(instead of accessing a data, we now just give it a little delay)
  void getData() async {
/*
    //simulate network request for a username
    Future.delayed(Duration(seconds: 3), (){  //Future is the object and delayed is the method
                                              //2nd argument of Future is the function
                                              //which fires once the duration is over
      print('yoshi');
    });

//lets suppose the second request needs the username from the network request, so we can't make the 2nd
//request before 1st
    //simulate network request to get bio of the username
    Future.delayed(Duration(seconds: 2), (){
      print('vegan, musician & egg collector');
    });
    print('statement');
    //statement will get printed first, then vegan, then yoshi
  }

 */

/*
//if below request depends upon the execution of first, then this kind of code won't work
//because we are starting second before first is completed
//Solution is to attach async after parenthesis and before curly braces in the main function(getData over here)
//and put await keyword(in the function name)
    //the below line means: wait right here until its done, before starting next line
    await Future.delayed(Duration(seconds: 3), (){
      print('yoshi');
    });

    Future.delayed(Duration(seconds: 2), (){
      print('vegan, musician & egg collector');       //now there will be synchronous flow of code(2nd after 1st)
    });
    print('statement');

*/
    //an api request will return us a string value
    String username = await Future.delayed(Duration(seconds: 3), () {
      return 'yoshi';
    });

    String bio = await Future.delayed(Duration(seconds: 2), () {
      //we will use the username we got from previous api call and then return corresponding bio for it
      return 'vegan, musician & egg collector';
    });

    print('$username - $bio');
    //we are waiting for each request to move on(this method is only good when one request depends on other)
  }
  @override
  void initState() {
    super.initState();
    //call getData function from initState (after 3 seconds text appears in console)
    getData();
  }
  */
  //cutting and pasting the getData and init function into loading.dart
  // (since we will load the data from the loading screen)

  List<WorldTime> locations = [
    WorldTime(url: 'Europe/London', location: 'London', flag: 'uk.png'),
    WorldTime(url: 'Europe/Athens', location: 'Athens', flag: 'greece.png'),
    WorldTime(url: 'Africa/Cairo', location: 'Cairo', flag: 'egypt.png'),
    WorldTime(url: 'Africa/Nairobi', location: 'Nairobi', flag: 'kenya.png'),
    WorldTime(url: 'America/Chicago', location: 'Chicago', flag: 'usa.png'),
    WorldTime(url: 'America/New_York', location: 'New York', flag: 'usa.png'),
    WorldTime(url: 'Asia/Seoul', location: 'Seoul', flag: 'south_korea.png'),
    WorldTime(url: 'Asia/Jakarta', location: 'Jakarta', flag: 'indonesia.png'),
    WorldTime(url: 'Asia/Kolkata', location: 'Kolkata', flag: 'india.png'),
    WorldTime(
        url: 'Australia/Sydney', location: 'Australia', flag: 'australia.png'),
  ];

  //our task is to cycle through the list and output template for each item in the list(we used map earlier, now we will use -
  //list view builder: will be used which returns widget template for each item
  void updateTime(index) async {
    WorldTime instance = locations[index];
    await instance
        .getTime(); //getTime is async and hence we add await, as we will wait for it to complete
    //navigate to home screen
    //to reroute we used navigator.pushed name . Now we don't want to do this right now
    //we want to pop this one back off

    Navigator.pop(context, {
      //pop has a diff syntax, no need to write argument keyword
      //copied this from loading.dart
      'location': instance.location,
      'flag': instance.flag,
      'time': instance.time,
      'isDaytime': instance.isDaytime,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text('Choose a Location'),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        //no of items inside the list
        itemCount: locations.length,
        itemBuilder: (context, index) {
          //will return widget template
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
            child: Card(
              child: ListTile(
                  //see in documentation, image on left and text on right
                  onTap: () {
                    updateTime(index);
                  },
                  title: Text(locations[index].location),
                  leading: CircleAvatar(
                    //to output image next to each one
                    backgroundImage:
                        AssetImage('assets/${locations[index].flag}'),
                  )),
            ),
          );
        },
      ),
    );
  }
}
