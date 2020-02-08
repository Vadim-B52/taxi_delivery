import 'package:flutter/material.dart';
import 'delivering_page.dart';

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
        'delivery_page': (context) => DeliveryPage(),
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
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (BuildContext context, int index) {
          switch (index) {
            case 0:
              return RaisedButton(
                onPressed: () => Navigator.pushNamed(context, 'delivery_page'),
                child: Text('Delivery Page'),
              );
            default:
              return null;
          }
        },
      ),
    );
  }
}
