import 'package:agri_doc/community_screen.dart';
import 'package:agri_doc/crop_disease_screen.dart';
import 'package:agri_doc/crop_suggestion_screen.dart';
import 'package:agri_doc/forcastmain.dart';
import 'package:agri_doc/question_screen.dart';
import 'package:agri_doc/soil_parameter_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'use_card_widget.dart';
import 'use_card_child.dart';

class HomeScreen extends StatefulWidget {
  static const String id = "HomeScreen";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: UseCard(
                      routeId: QuestionScreen.id,
                      cardChild: UseCardChild(
                        childIcon: 'assets/shake-hand.png',
                        childText: "Deal",
                      ),
                    ),
                  ),
                  Expanded(
                    child: UseCard(
                      routeId: CropDiseaseScreen.id,
                      cardChild: UseCardChild(
                        childIcon: 'assets/weed.png',
                        childText: "Crop Disease",
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: UseCard(
                      routeId: SoilParameterScreen.id,
                      cardChild: UseCardChild(
                        childIcon: 'assets/weather.png',
                        childText: "Soil Parameters",
                      ),
                    ),
                  ),
                  Expanded(
                    child: UseCard(
                      routeId: SuggestionScreen.id,
                      cardChild: UseCardChild(
                        childIcon: 'assets/doubt.png',
                        childText: "Crop Suggestion",
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: UseCard(
                      routeId: ForecastScreen.id,
                      cardChild: UseCardChild(
                        childIcon: 'assets/forecast.png',
                        childText: "Weather Forecast",
                      ),
                    ),
                  ),
                  Expanded(
                    child: UseCard(
                      routeId: CommunityScreen.id,
                      cardChild: UseCardChild(
                        childIcon: 'assets/community.png',
                        childText: "Farmer Community",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}




