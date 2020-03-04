import 'package:agri_doc/crop_disease_screen.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UseCard extends StatelessWidget {
  UseCard({
    @required this.cardChild, this.routeId
  });

  final Widget cardChild;
  final String routeId;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()  {
        if(routeId!="18001801551") {
          Navigator.pushNamed(context, routeId);
        } else {
          try {
            launch("tel:$routeId");
          } catch(e) {
            print(e);
          }
        }
      },
      child: Container(
        child: cardChild,
        margin: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0)),
      ),
    );
  }
}