import 'package:agri_doc/ForecastData.dart';
import 'package:agri_doc/community_screen.dart';
import 'package:agri_doc/crop_disease_screen.dart';
import 'package:agri_doc/crop_suggestion_screen.dart';
import 'package:agri_doc/forcastmain.dart';
import 'package:agri_doc/loading_screen.dart';
import 'package:agri_doc/loading_screen_all.dart';
import 'package:agri_doc/loading_screen_order.dart';
import 'package:agri_doc/order_screen.dart';
import 'package:agri_doc/pref_screen.dart';
import 'package:agri_doc/question_screen.dart';
import 'package:agri_doc/register_screen.dart';
import 'package:agri_doc/soil_parameter_screen.dart';
import 'package:agri_doc/splash_screen.dart';
import 'package:flutter/material.dart';
import 'home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KrishiSahay',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),

      initialRoute: SplashScreen.id ,

      routes: {
        HomeScreen.id: (context) => HomeScreen(),
        RegisterScreen.id: (context) => RegisterScreen(),
        CropDiseaseScreen.id: (context) => CropDiseaseScreen(),
        SoilParameterScreen.id: (context) => SoilParameterScreen(),
        CommunityScreen.id: (context) => CommunityScreen(),
        SplashScreen.id: (context) => SplashScreen(),
        SuggestionScreen.id: (context) => SuggestionScreen(),
        ForecastScreen.id: (context) => ForecastScreen(),
        LoadingScreen.id: (context) => LoadingScreen(),
        QuestionScreen.id: (context) => QuestionScreen(),
        LoadingScreenAll.id: (context) => LoadingScreenAll(),
        PrefScreen.id: (context) => PrefScreen(),
        OrderScreen.id: (context) => OrderScreen(),
        LoadingScreenOrder.id: (context) => LoadingScreenOrder(),
      },
    );
  }
}
