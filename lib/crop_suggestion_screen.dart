import 'package:agri_doc/result_screen.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SuggestionScreen extends StatefulWidget {
  static const String id = "SuggestionScreen";

  @override
  _SuggestionScreenState createState() => _SuggestionScreenState();
}

class _SuggestionScreenState extends State<SuggestionScreen> {

  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  Position _currentPosition;
  String _currentAddress=null;

  final _firestore = Firestore.instance;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crop Sugggestion'),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.all(20.0),child: Center(child: Text('Finding the best crop to cultivate...', style: TextStyle(fontSize: 16.0),)))
          ],
        ),
      ),
    );
  }

  _getCurrentLocation() {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.lowest)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });

      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];

      setState(() {
        _currentAddress =
        "${place.locality}";


        var now = new DateTime.now();
        String g = ('${now.month}');
        _firestore.collection('crop_suggestion').document('suggestion').updateData({
          'district': 'Coimbatore',
          'month': g,
          'result_suggestion':''
        });
        Firestore.instance.collectionGroup('crop_suggestion').snapshots().listen((data) {
          data.documentChanges.forEach((change) {
            String resultGiven = change.document.data['result_suggestion'];
            if(change.document.data['result_suggestion']!='') {
              print(resultGiven);
            }
          });
        });

      });
    } catch (e) {
      print(e);
    }
  }

}
