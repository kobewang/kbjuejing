import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class  HotPage extends StatefulWidget{
  @override
  HotPageState createState() => new HotPageState();
}
class HotPageState extends State<HotPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('hotpage'),),
      body: Center(
        child: Text('this is hot page'),
      ),
    );
  }
}