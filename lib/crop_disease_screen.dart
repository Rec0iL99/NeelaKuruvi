import 'dart:io';
import 'package:agri_doc/home_screen.dart';
import 'package:agri_doc/result_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:progress_dialog/progress_dialog.dart';

class CropDiseaseScreen extends StatefulWidget {
  static const String id = "CropDiseaseScreen";

  @override
  _CropDiseaseScreenState createState() => _CropDiseaseScreenState();
}

class _CropDiseaseScreenState extends State<CropDiseaseScreen> {

  bool isShowing = false;
  File _image;
  ProgressDialog pr;

  final _firestore = Firestore.instance;

  Future getImage() async {
    try {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);

      setState(() {
        if(image!=null) {
          _image = image;
        }
      });
    } catch(e) {
        print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Crop Disease'),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            !isShowing ? Expanded(
              child: Align(
                alignment: FractionalOffset.center,
                child: Text('No Image selected'),
              ),
            ) : Expanded(
              child: Align(
                alignment: FractionalOffset.center,
                child: Image.file(_image),
              ),
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: Padding(
                        padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                        child: SizedBox(
                          width: double.maxFinite,
                          child: MaterialButton(
                            color: Colors.green,
                            onPressed: () {
                              setState(() {
                                getImage();
                                this.isShowing = true;
                              });
                            },
                            child: Text(
                              'Select Crop',
                              style: TextStyle(color: Colors.white, fontSize: 16.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: Padding(
                        padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                        child: SizedBox(
                          width: double.maxFinite,
                          child: MaterialButton(
                            color: Colors.green,
                            onPressed: () async {
                              String url = await urlDownload(_image);
                              _firestore.collection('crop_disease').document('crop_image').updateData({
                                'image_url':url,
                                'result_disease':''
                              });
//                              Navigator.pushNamed(context, HomeScreen.id);
                              Firestore.instance.collectionGroup('crop_disease').snapshots().listen((data) {
                                data.documentChanges.forEach((change) {
                                  String resultGiven = change.document.data['result_disease'];
                                  if(change.document.data['result_disease']!='') {
                                    pr.hide().then((isHidden) {
                                      print(isHidden);
                                    });
                                    print(resultGiven);
                                    Navigator.of(context).push(
                                        new MaterialPageRoute(
                                            builder: (context) {
                                              return ResultScreen(
                                                result: resultGiven,
                                              );
                                            })
                                    );
                                  }
                                });
                              });
                            },
                            child: Text(
                              'Process',
                              style: TextStyle(color: Colors.white, fontSize: 16.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
      ),
    );
  }

  Future<String> urlDownload(file) async {
    pr = new ProgressDialog(context,type: ProgressDialogType.Normal, isDismissible: false, showLogs: false);
    pr.style(
        message: 'Processing...');
    pr.show();
    StorageReference ref =
    FirebaseStorage.instance.ref().child("cropdisease.jpg");
    StorageUploadTask uploadTask = ref.putFile(file);

    String downloadUrl =
    await (await uploadTask.onComplete).ref.getDownloadURL();
    return downloadUrl;
  }
}
