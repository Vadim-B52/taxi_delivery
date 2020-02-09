import 'package:flutter/material.dart';

import 'adventures/b/pickup_adventure.dart';
import 'screens/pickup_page.dart';
import 'delivering_page.dart';
import 'map_page.dart';
import 'sliding_page.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
//        textTheme: TextTheme(
//          title:
//        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => ListOfPages(),
        '/delivery_page': (context) => DeliveryPage(),
        '/map': (context) => MapPage(),
        '/sliding': (context) => SlidingPage(),
        '/pickup': (context) => PickupPage()
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
          RaisedButton(
            onPressed: () => Navigator.pushNamed(context, '/sliding'),
            child: Text('Slide Page'),
          ),
          RaisedButton(
            onPressed: () => Navigator.pushNamed(
              context,
              '/pickup',
              arguments: PickupPageArguments(route: PickupRoute.exampleData()),
            ),
            child: Text('Pickup Page'),
          ),
        ],
      ),
    );
  }
}
