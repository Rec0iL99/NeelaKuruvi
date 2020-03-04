
import 'package:agri_doc/loading_screen_order.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PrefScreen extends StatefulWidget {
  static const String id = "PrefScreen";

  PrefScreen({this.email, this.crops});

  String email;
  String crops;

  @override
  _PrefScreenState createState() => _PrefScreenState();
}

class _PrefScreenState extends State<PrefScreen> {
  List<bool> boolList = new List<bool>();
  List<String> inputList = new List<String>();
  List<String> prefList = new List<String>();

  final _firestore = Firestore.instance;

  @override
  void initState() {
    setState(() {
      widget.crops.replaceAll(new RegExp(r"\s+\b|\b\s"), "");
      inputList = widget.crops.split(',');

      for (int i = 0; i < inputList.length; i++) {
        boolList.add(false);
      }
    });
  }

  void ItemChange(bool val, int index) {
    if (val == false) {
      setState(() {
        boolList[index] = val;
      });
    } else {
      var count = 0;
      for (var i = 0; i < inputList.length; i++) {
        if (boolList[i] == true) {
          count++;
        }
      }

      if (count <= 2) {
        setState(() {
          boolList[index] = val;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        title: Text('Select any 3 prefrences'),
        elevation: 0,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                for(var i=0; i<boolList.length; i++) {
                  if(boolList[i] == true) {
                    prefList.add(inputList[i].replaceAll(new RegExp(r"\s+\b|\b\s"), ""));
                  }
                }
                if(prefList.length==3) {
                  print(prefList);
                  print(widget.email);
                  _firestore.collection('seller').document(widget.email).updateData({
                    'pref1': prefList[0],
                    'pref2': prefList[1],
                    'pref3': prefList[2],
                  });
                  Navigator.of(context).push(
                      new MaterialPageRoute(
                          builder: (context) {
                            return LoadingScreenOrder(
                              email: widget.email,
                            );
                          })
                  );
                }
              },
              child: Icon(Icons.send),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 16.0),
          child: ListView.builder(
            itemCount: boolList.length,
            itemBuilder: (BuildContext context, int index) {
              return new Card(
                child: new Container(
                  padding: new EdgeInsets.all(10.0),
                  child: new Column(
                    children: <Widget>[
                      new CheckboxListTile(
                        value: boolList[index],
                        title: new Text('${inputList[index]}'),
                        controlAffinity: ListTileControlAffinity.leading,
                        onChanged: (bool val) {
                          ItemChange(val, index);
                          print(boolList);

                        },
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
