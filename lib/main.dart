import 'package:flutter/material.dart';
import 'pages/indexpage.dart';
import 'pages/search.dart';
import 'pages/activities.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'actions/actions.dart';
import 'reducers/reducers.dart';

void main() {
  final userInfo = new Store<Map>(getUserInfo, initialState: {});    
  runApp(new MyApp(
    store: userInfo,
  ));
}
class MyApp extends StatelessWidget{  
  final Store<Map> store;
  MyApp({Key key,this.store}): super(key:key);
  @override  
  Widget build(BuildContext context){
    return new StoreProvider(
      store: store,
      child: new  MaterialApp(
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
          '/activities':(BuildContext context) => ActivitiesPage()
          //'/books':(BuildContext context) => BookPage()
        },
      ),
    );
     
  }
}