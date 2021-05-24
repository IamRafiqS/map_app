import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:collection';
import 'package:location/location.dart';

class GMap extends StatefulWidget {
  GMap({Key key}) : super(key: key);

  @override
  _GMapState createState() => _GMapState();
}

class _GMapState extends State<GMap> {

  Set<Marker> _markers = HashSet<Marker>();
  Set<Polygon> _polygons = HashSet<Polygon>();
  Set<Polyline> _polylines = HashSet<Polyline>();
  Set<Circle> _circles = HashSet<Circle>();
  bool _showMapStyle = false;
  String image = 'assets/beachflag.png';

  GoogleMapController _mapController;
  BitmapDescriptor _markerIcon;
  Location location = new Location();

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;


  @override
  void initState() {
    super.initState();
    // TODO change marker Icon
    _setMarkerIcon();
    _setPolygons();
    _setPolylines();
    _setCircles();
  }

  void _setMarkerIcon() async {
    _markerIcon = await BitmapDescriptor.defaultMarkerWithHue(60.0);
  }

  void _setMapStyle() async {
    String style = await DefaultAssetBundle.of(context).loadString('assets/map_style.json');

    _mapController.setMapStyle(style);
  }

  void _setPolygons() {
    List<LatLng> polygonLatLongs = List<LatLng>();
    polygonLatLongs.add(LatLng(37.78493, -122.42932));
    polygonLatLongs.add(LatLng(37.78693, -122.41942));
    polygonLatLongs.add(LatLng(37.78923, -122.41542));
    polygonLatLongs.add(LatLng(37.78923, -122.42582));

    _polygons.add(
      Polygon(
        polygonId: PolygonId("0"),
        points: polygonLatLongs,
        fillColor: Colors.white,
        strokeWidth: 1,
      ),
    );
  }

  void _setPolylines() {
    List<LatLng> polylineLatLongs = List<LatLng>();
    polylineLatLongs.add(LatLng(37.74493, -122.42932));
    polylineLatLongs.add(LatLng(37.74693, -122.41942));
    polylineLatLongs.add(LatLng(37.74923, -122.41542));
    polylineLatLongs.add(LatLng(37.74923, -122.42582));

    _polylines.add(
      Polyline(
        polylineId: PolylineId("0"),
        points: polylineLatLongs,
        color: Colors.red,
        width: 1,
      ),
    );
  }

  void _setCircles() {
    _circles.add(
      Circle(
          circleId: CircleId("0"),
          center: LatLng(37.76493, -122.42432),
          radius: 1000,
          strokeWidth: 2,
          fillColor: Colors.grey),
    );
  }

  void _onMapCreated(GoogleMapController controller){
    _mapController = controller;

    setState(() {
      _markers.add(Marker(markerId: MarkerId("0"),
      position: LatLng(37.77483, -122.41942),
        // TODO change Icon
        icon: _markerIcon,
      infoWindow: InfoWindow(
        title: "San Francisco",
        snippet: "Amazing"
      ),
      )
      );
    });
    _setMapStyle();
  }

  @override
  Widget build(BuildContext context) {
    return
      SizedBox(height: double.infinity, width: 2621,
          child:

      GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
        target: LatLng(37.77483, -122.41942),
        zoom: 13
      ),
        markers: _markers,
        polygons: _polygons,
        polylines: _polylines,
        circles: _circles,

        // TODO enable location
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
      )
    );
  }
}
