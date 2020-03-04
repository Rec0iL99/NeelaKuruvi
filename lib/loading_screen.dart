import 'package:agri_doc/NewsScreen.dart';
import 'package:agri_doc/news_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class LoadingScreen extends StatefulWidget {

  static const String id = "NewsScreen";

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    NetworkHelper networkHelper = NetworkHelper('http://newsapi.org/v2/everything?q=bitcoin&from=2020-01-28&sortBy=publishedAt&apiKey=a04f7099a8f94a549d076e67e00481b7');
    var data = await networkHelper.getData();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return NewsScreen();
    }));
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }
}
