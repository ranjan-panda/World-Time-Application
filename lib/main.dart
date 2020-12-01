import 'package:flutter/material.dart';
//import 'pages/home.dart';
//another way to import(it knows to direct into lib..so need to mention)
import 'package:world_time/pages/home.dart';
import 'package:world_time/pages/loading.dart';
import 'package:world_time/pages/choose_location.dart';
//we are creating widget for home screen,choose_location screen and for loading screen

//example of what is map and the way it's being used in 'routes'
// void main(){
//   Map student ={'name': 'chun-li', 'age': 25};
//   //two properties :name and age
//   //corresponding two values: chun-li and 25
//   print(student['age']);
// }

// //we will do similar thing for route. In routes property, we have route on left and the widget to be loaded for that route on right
void main() {
  runApp(MaterialApp(
    // //need to delete the below code, coz it's conflicting with the base route in routes
    // home: Home(),

    //property initialRoute overrides the default route and runs the widget you want
    //the default initialRoute is '/'
    initialRoute: '/',
    //routes property which is a map, will expect the actual routes('/about' or '/contact') for keys and
    routes: {
      //single forward slash is the base route(the first screen we see). the values of these diff routes
      // will be functions, which takes context object as an argument
      // context object keeps track of where we are in the widget tree
      '/': (context) => Loading(),
      '/home': (context) => Home(),
      '/location': (context) => ChooseLocation(),
    }
  ));
}
/*
the build func in stateless runs only once, whereas the setState() triggers the build function whenever called
Stateful widget has couple of lifecycle methods:
#initstate()
-called only once when the widget is created

#Build()
-

Dispose()
-when the widget/state object is removed
 */
