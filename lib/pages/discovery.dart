import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DiscoveryPage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: AppBar(title: Text('发现'),),
      body: Center(
        child: Text('this is 发现'),
      ),
    );
  }
}
