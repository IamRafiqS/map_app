import 'package:flutter/material.dart';
import 'package:google_map/Gmap.dart';
import 'package:location/location.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Google Maps'),
    );
  }

}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  void initState() {
    super.initState();
    _getLocationPermission();
  }


  void _getLocationPermission() async {
    var location = new Location();
    try {
      location.requestPermission();
    } on Exception catch (_) {
      print('There was a problem allowing location access');
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body:
          Container(
            alignment: Alignment.bottomRight,
            child:
            FloatingActionButton(
              tooltip: 'increment',
              child: Icon(Icons.map_rounded),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GMap()),
              ),
            ),
          ),
    );
  }

}
