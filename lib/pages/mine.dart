import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class MinePage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text('mine page') ,),
      body: Center(
        child: Text('this is mine page'),
      ),
    );
  }
}
