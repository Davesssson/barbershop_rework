import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rxdart/rxdart.dart';


class GeoQueryExampleMine extends StatefulWidget {
  @override
  _GeoQueryExampleMineState createState() => _GeoQueryExampleMineState();
}

class _GeoQueryExampleMineState extends State<GeoQueryExampleMine> {
  GoogleMapController? _mapController;
  TextEditingController? _latitudeController, _longitudeController;

  // firestore init
  final radius = BehaviorSubject<double>.seeded(1.0);
  final _firestore = FirebaseFirestore.instance;
  final markers = <MarkerId, Marker>{};

  late Stream<List<DocumentSnapshot>> stream;
  late Geoflutterfire geo;

  double _value = 20.0;
  String _label = '';

  @override
  void initState() {
    super.initState();
    _latitudeController = TextEditingController();
    _longitudeController = TextEditingController();

    geo = Geoflutterfire();
    GeoFirePoint center = geo.point(latitude: 47.497913, longitude:19.040236);
    stream = radius.switchMap((rad) {
      final collectionReference = _firestore.collection('barbershops');

      return geo.collection(collectionRef: collectionReference).within(
          center: center, radius: rad, field: 'point', strictMode: true);
    });
  }

  @override
  void dispose() {
    _latitudeController?.dispose();
    _longitudeController?.dispose();
    radius.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('GeoFlutterFire'),
        ),

        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Card(
                  elevation: 4,
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: SizedBox(
                    width: mediaQuery.size.width - 30,
                    height: mediaQuery.size.height * (1 / 3),
                    child: GoogleMap(
                      onMapCreated: _onMapCreated,
                      initialCameraPosition: const CameraPosition(
                        target: LatLng(47.497913, 19.040236),
                        zoom: 15.0,
                      ),
                      markers: Set<Marker>.of(markers.values),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Slider(
                  min: 1,
                  max: 200,
                  divisions: 4,
                  value: _value,
                  label: _label,
                  activeColor: Colors.blue,
                  inactiveColor: Colors.blue.withOpacity(0.2),
                  onChanged: (double value) {
                    setState(() {
                      _value = value;
                      _label = '${_value.toInt().toString()} kms';
                      markers.clear();
                    });
                    radius.add(value);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _mapController = controller;
      stream.listen((List<DocumentSnapshot> documentList) {
        _updateMarkers(documentList);
      });
    });
  }

  void _addMarker(double lat, double lng) {
    final id = MarkerId(lat.toString() + lng.toString());
    final _marker = Marker(
      markerId: id,
      position: LatLng(lat, lng),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
      infoWindow: InfoWindow(title: 'latLng', snippet: '$lat,$lng'),
    );
    setState(() {
      markers[id] = _marker;
    });
  }

  void _updateMarkers(List<DocumentSnapshot> documentList) {
    documentList.forEach((DocumentSnapshot document) {
      final data = document.data() as Map<String, dynamic>;
      final GeoPoint point = data['point']['geopoint'];
      _addMarker(point.latitude, point.longitude);
    });
  }
}