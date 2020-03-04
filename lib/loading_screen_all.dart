import 'package:agri_doc/home_screen.dart';
import 'package:agri_doc/pref_screen.dart';
import 'package:agri_doc/result_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoadingScreenAll extends StatefulWidget {
  static const String id = "LoadingScreenAll";

  LoadingScreenAll({this.email});

  final String email;

  @override
  _LoadingScreenAllState createState() => _LoadingScreenAllState();
}

class _LoadingScreenAllState extends State<LoadingScreenAll> {
  Color bgColor = Color(0xff272343);
  Color fieldColor = Color(0xff514b6e);
  final _firestore = Firestore.instance;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.green,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              StreamBuilder(
                stream: Firestore.instance
                    .collection('seller')
                    .document(widget.email)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.data['crop_list']!='') {
                    String crops = snapshot.data['crop_list'];
                    Future.delayed(const Duration(milliseconds: 100), () {
//                      Navigator.of(context)
//                          .pushNamedAndRemoveUntil(HomeScreen.id, (Route<dynamic> route) => false);
                      Navigator.pushAndRemoveUntil(context,
                          MaterialPageRoute(builder: (BuildContext context) => PrefScreen(email: widget.email,crops: crops)),
                          ModalRoute.withName('/'));
                    });
                    return Text('..');
                  } else {
                    return Text('..');
                  }
                },
              ),
              SpinKitDoubleBounce(
                color: Colors.white,
                size: 100.0,
              ),
            ],
          ),
        ));
  }
}
