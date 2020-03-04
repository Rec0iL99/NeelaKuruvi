import 'package:agri_doc/home_screen.dart';
import 'package:agri_doc/order_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoadingScreenOrder extends StatefulWidget {

  static const String id = "LoadingScreenOrder";

  LoadingScreenOrder({this.email});

  final String email;

  @override
  _LoadingScreenOrderState createState() => _LoadingScreenOrderState();
}

class _LoadingScreenOrderState extends State<LoadingScreenOrder> {
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
                  if (snapshot.data['assigned']=='True') {
                    String crop = snapshot.data['assigned_crop'];
                    String quantity = snapshot.data['assigned_quantity'];
                    String vendor = snapshot.data['vendorid'];
                    print(crop+quantity+vendor);
                    Future.delayed(const Duration(milliseconds: 100), () {
//                      Navigator.of(context)
//                          .pushNamedAndRemoveUntil(HomeScreen.id, (Route<dynamic> route) => false);
                      Navigator.pushAndRemoveUntil(context,
                          MaterialPageRoute(builder: (BuildContext context) => OrderScreen(vendorid: vendor, crop: crop, quantity: quantity,email: widget.email,)),
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
