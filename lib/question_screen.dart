import 'package:agri_doc/loading_screen_all.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:beauty_textfield/beauty_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class QuestionScreen extends StatefulWidget {
  static const String id = "QuestionScreen";

  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {

  final _firestore = Firestore.instance;
  Color bgColor = Color(0xff272343);
  Color fieldColor = Color(0xff514b6e);

  String hectars;
  String name;
  String aId;
  String userEmail;

  final _name = TextEditingController();
  final _aadhaar = TextEditingController();
  final _hectar = TextEditingController();


  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;

  void getUser() async {
    try {
      final user = await _auth.currentUser();
      if(user!=null) {
        loggedInUser = user;
        userEmail =  loggedInUser.email;
      }
    } catch(e) {
      print(e);
    }
  }

  @override
  void initState() {
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 60.0, left: 20.0, right: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'What is your name?',
                    style: TextStyle(
                        fontSize: 25.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  TextField(
                    controller: _name,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.all(
                                Radius.circular(20))),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.all(
                                Radius.circular(20))),
                        prefixIcon: Icon(Icons.people),
                        hintText: "Your Answer",
                        filled: true,
                        fillColor: Colors.white),
                  ),
                  SizedBox(height: 15.0),
                  Text(
                    'What is your Adhaar ID?',
                    style: TextStyle(
                      fontSize: 25.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  TextField(
                    controller: _aadhaar,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.all(
                                Radius.circular(20))),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.all(
                                Radius.circular(20))),
                        prefixIcon: Icon(Icons.perm_identity),
                        hintText: "Your Answer",
                        filled: true,
                        fillColor: Colors.white),
                  ),
                  SizedBox(height: 15.0),
                  Text(
                    'How many hectars do you own?',
                    style: TextStyle(
                      fontSize: 25.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  TextField(
                    controller: _hectar,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.all(
                                Radius.circular(20))),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.all(
                                Radius.circular(20))),
                        prefixIcon: Icon(Icons.accessibility),
                        hintText: "Your Answer",
                        filled: true,
                        fillColor: Colors.white),
                  ),
                  Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: 10.0, vertical: 30.0),
                    child: SizedBox(
                      width: double.maxFinite,
                      height: 50.0,
                      child: MaterialButton(
                        color: fieldColor,
                        onPressed: () {
                          var now = new DateTime.now();
                          String g = ('${now.month}');
                          _firestore.collection('seller').document(userEmail).setData({
                            'name': _name.text,
                            'id': _aadhaar.text,
                            'location':'Coimbatore',
                            'hectars':_hectar.text,
                            'crop_list':'',
                            'pref1':'',
                            'pref2':'',
                            'pref3':'',
                            'season':g,
                            'assigned':'false',
                            'assigned_crop':'',
                            'assigned_quantity':'',
                            'vendorid':'',
                          });


                          Navigator.of(context).push(
                              new MaterialPageRoute(
                                  builder: (context) {
                                    return LoadingScreenAll(
                                      email: userEmail,
                                    );
                                  })
                          );
                        },
                        child: Text('Suggest', style: TextStyle(color: Colors.white, fontSize: 18.0),),

                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
