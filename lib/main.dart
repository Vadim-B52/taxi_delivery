import 'package:flutter/material.dart';
import 'delivering_page.dart';
import 'map_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => ListOfPages(),
        '/delivery_page': (context) => DeliveryPage(),
        '/map': (context) => MapPage(),
      },
    );
  }
}

class ListOfPages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of Pages'),
      ),
      body: ListView(
        children: <Widget>[
          RaisedButton(
            onPressed: () => Navigator.pushNamed(context, '/delivery_page'),
            child: Text('Delivery Page'),
          ),
          RaisedButton(
            onPressed: () => Navigator.pushNamed(context, '/map'),
            child: Text('Map Page'),
          ),
        ],
      ),
    );
  }
}
