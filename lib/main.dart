import 'package:flutter/material.dart';
import 'pages/indexpage.dart';
import 'pages/search.dart';
import 'pages/activities.dart';

void main() => runApp(MyApp());
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return new  MaterialApp(
      home: new  IndexPage(),
      theme: ThemeData(
        splashColor: Colors.transparent,
        bottomAppBarColor: new Color.fromRGBO(244, 245, 245, 1.0),
        scaffoldBackgroundColor: new Color.fromRGBO(244, 245, 245, 1.0),
        backgroundColor: new Color.fromRGBO(244, 245, 245, 1.0),
        primaryIconTheme: new IconThemeData(color: Colors.blue),
        indicatorColor: Colors.blue,
        iconTheme: new IconThemeData(size:18.0),
        primaryTextTheme: new TextTheme(
          title: new TextStyle(color: Colors.black,fontSize: 16.0)
        )
      ),
      routes: <String,WidgetBuilder>{
        '/search': (BuildContext context) => SearchPage(),
        '/activities':(BuildContext context) => ActivitesPage()
        //'/books':(BuildContext context) => BookPage()
      },
    );
  }
}