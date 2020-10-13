import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Admin/adminShiftOrders.dart';
import 'package:e_shop/Widgets/loadingWidget.dart';
import 'package:e_shop/main.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as ImD;

class UploadPage extends StatefulWidget {
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage>
    with AutomaticKeepAliveClientMixin<UploadPage> {
  bool get wantKeepAlive => true;
  File file;

  @override
  Widget build(BuildContext context) {
    return displayAdminHomeScreen();
  }

  displayAdminHomeScreen() {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Colors.deepPurpleAccent, Colors.blue]),
            ),
          ),
          leading: IconButton(
              icon: Icon(
                Icons.border_color,
                color: Colors.white,
              ),
              onPressed: () {
                Route route =
                    MaterialPageRoute(builder: (c) => AdminShiftOrders());
                Navigator.pushReplacement(context, route);
              }),
          actions: [
            FlatButton(
                child: Text(
                  "LogOut",
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                ),
                onPressed: () {
                  Route route =
                      MaterialPageRoute(builder: (c) => SplashScreen());
                  Navigator.pushReplacement(context, route);
                })
          ],
          brightness: Brightness.light,
          backgroundColor: Color(0xFF21BFBD),
          title: Text('Cano_eshop'),
          centerTitle: false,
        ),
      ),
      body: getAdminHomeScreenBody(),
    );
  }

  getAdminHomeScreenBody() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[Colors.deepPurpleAccent, Colors.blue],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shop_two, color: Colors.white, size: 200.0),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9.0),
                ),
                child: Text(
                  "Add New Items",
                  style: TextStyle(fontSize: 30.0, color: Colors.white),
                ),
                color: Colors.green,
                onPressed: () => fetchImage(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  fetchImage(mContext) {
    return showDialog(
        context: mContext,
        builder: (con) {
          return SimpleDialog(
            title: Text(
              "Item Image",
              style: TextStyle(
                  color: Colors.deepPurpleAccent, fontWeight: FontWeight.bold),
            ),
            children: [
              SimpleDialogOption(
                child: Text(
                  "Capture With Camera",
                  style: TextStyle(
                      color: Colors.deepPurpleAccent,
                      fontWeight: FontWeight.w900),
                ),
                  onPressed: captPhoto,
              ),
              SimpleDialogOption(
                child: Text(
                  "Select From Gallery",
                  style: TextStyle(
                      color: Colors.deepPurpleAccent,
                      fontWeight: FontWeight.w900),
                ),
                onPressed: captPhotogallery,
              ),
              SimpleDialogOption(
                child: Text(
                  "Cancel",
                  style: TextStyle(
                      color: Colors.deepPurpleAccent,
                      fontWeight: FontWeight.w900),
                ),
              ),
            ],
          );
        });
  }

  captPhoto() async{
Navigator.pop(context);
File ImageFile=await ImagePicker.pickImage(source: ImageSource.camera,maxHeight: 669.0,maxWidth:970.0);
setState(() {
  file=ImageFile;
});
  }
  captPhotogallery() async{
    Navigator.pop(context);
    File ImageFile=await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      file=ImageFile;
    });

  }
}
