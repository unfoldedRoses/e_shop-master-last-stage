import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Widgets/customTextField.dart';
import 'package:e_shop/DialogBox/errorDialog.dart';
import 'package:e_shop/DialogBox/loadingDialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Store/storehome.dart';
import 'package:e_shop/Config/config.dart';
import 'package:e_shop/animation/FadeAnimation.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  EcommerceApp.auth = FirebaseAuth.instance;
  EcommerceApp.sharedPreferences = await SharedPreferences.getInstance();
  EcommerceApp.firestore = Firestore.instance;

  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: Register()));
}

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _nameTextEditingController =
  TextEditingController();
  final TextEditingController _emailTextEditingController =
  TextEditingController();
  final TextEditingController _passwordTextEditingController =
  TextEditingController();
  final TextEditingController _cPasswordTextEditingController =
  TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String userImageUrl = "";
  File _imageFile;

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    final width = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 400,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: -40,
                      height: 400,
                      width: width * 1,
                      child: FadeAnimation(
                        1,
                        Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/canos.png'),
                                  fit: BoxFit.fill)),
                        ),
                      ),
                    ),
                    Positioned(
                      height: 400,
                      width: width + 20,
                      child: FadeAnimation(
                          1.3,
                          Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image:
                                    AssetImage('assets/background-2.png'),
                                    fit: BoxFit.fill)),
                          )),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              new Center(
                child: new Container(
                  child: new Material(
                    child: new InkWell(
                      onTap: _selectImage,
                      child: new Container(
                          width: 100.0,
                          height: 100.0,
                          child: new CircleAvatar(
                            radius: _screenWidth = 0.15,
                            backgroundColor: Colors.white,
                            backgroundImage: _imageFile == null
                                ? null
                                : FileImage(_imageFile),
                            child: _imageFile == null
                                ? Icon(
                              Icons.add_photo_alternate,
                              size: _screenWidth * 0.15,
                              color: Colors.grey,
                            )
                                : null,
                          )),
                    ),
                    color: Colors.transparent,
                  ),
                  color: Colors.orange,
                ),
              ),
              Container(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    InkWell(
                        onTap: _selectImage,
                        child: CircleAvatar(
                          radius: _screenWidth = 0.15,
                          backgroundColor: Colors.purple,
                          backgroundImage:
                          _imageFile == null ? null : FileImage(_imageFile),
                          child: _imageFile == null
                              ? Icon(
                            Icons.add_photo_alternate,
                            size: _screenWidth * 0.15,
                            color: Colors.grey,
                          )
                              : null,
                        ))
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FadeAnimation(
                        1.5,
                        Text(
                          "Register",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30),
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    FadeAnimation(
                        1.7,
                        Form(
                          key: _formKey,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.purple[50],
                                  blurRadius: 25.0, // soften the shadow
                                  spreadRadius: 5.0, //extend the shadow
                                  offset: Offset(
                                    10.0, // Move to right 10  horizontally
                                    1.0, // Move to bottom 10 Vertically
                                  ),
                                )
                              ],
                            ),
                            child: Column(
                              children: <Widget>[
                                CustomTextField(
                                    controller: _nameTextEditingController,
                                    data: Icons.person,
                                    hintText: "Name",
                                    isObsecure: false),
                                CustomTextField(
                                    controller: _emailTextEditingController,
                                    data: Icons.person,
                                    hintText: "Email",
                                    isObsecure: false),
                                CustomTextField(
                                    controller: _passwordTextEditingController,
                                    data: Icons.person,
                                    hintText: "password",
                                    isObsecure: true),
                                CustomTextField(
                                    controller: _cPasswordTextEditingController,
                                    data: Icons.person,
                                    hintText: "Confirm password",
                                    isObsecure: true),
                              ],
                            ),
                          ),
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    FadeAnimation(
                        1.9,
                        Container(
                          height: 50,
                          margin: EdgeInsets.symmetric(horizontal: 60),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Center(
                            child: MaterialButton(
                              minWidth: double.infinity,
                              height: 60,
                              onPressed: _uploadAndSave,
                              color: Colors.purple[200],
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)),
                              child: Text(
                                "Sign up",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 18),
                              ),
                            ),
                          ),
                        )),
                    SizedBox(
                      height: 30,
                    ),
                    FadeAnimation(
                        2,
                        Center(
                            child: Text(
                              "Create Account",
                            ))),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectImage() async {
    _imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
  }

  Future<void> _uploadAndSave() async {
    if (_imageFile == null) {
      showDialog(
          context: context,
          builder: (c) {
            return ErrorAlertDialog(
                message: "please selecte profile image before continue");
          });
    } else {
      _passwordTextEditingController.text ==
          _cPasswordTextEditingController.text
          ? _emailTextEditingController.text.isNotEmpty &&
          _passwordTextEditingController.text.isNotEmpty &&
          _cPasswordTextEditingController.text.isNotEmpty &&
          _nameTextEditingController.text.isNotEmpty
          ? uploadToStorage()
          : displayDialog("please fill up the small form")
          : displayDialog("password do not match");
    }
  }

  displayDialog(String msg) {
    showDialog(
        context: context,
        builder: (c) {
          return ErrorAlertDialog(message: msg);
        });
  }

  uploadToStorage() async {
    showDialog(
        context: context,
        builder: (_) {
          return LoadingAlertDialog();
        });
    String fileName = DateTime
        .now()
        .millisecondsSinceEpoch
        .toString();
    StorageReference reference =
    FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask = reference.putFile(_imageFile);
    StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
    await storageTaskSnapshot.ref.getDownloadURL().then((url) {
      userImageUrl = url;
      _register();
    });
  }



  FirebaseAuth _auth = FirebaseAuth.instance;
  void _register() async {
    FirebaseUser currentUser;
    await _auth
        .createUserWithEmailAndPassword(
      email: _emailTextEditingController.text.trim(),
      password: _passwordTextEditingController.text.trim(),
    )
        .then((auth) {
      currentUser = auth.user;
    }).catchError((error) {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (con) {
            return ErrorAlertDialog(
              message: error.message.toString(),
            );
          });
    });
    if (currentUser != null) {
      writeDataToDataBase(currentUser).then((s) {
        Navigator.pop(context);
        Route newRoute = MaterialPageRoute(builder: (_) => StoreHome());
        Navigator.pushReplacement(context, newRoute);
      });
    }
  }

  Future writeDataToDataBase(FirebaseUser currentUser) async {
    EcommerceApp.firestore
        .collection(EcommerceApp.collectionUser)
        .document(currentUser.uid)
        .setData({
      EcommerceApp.userUID: currentUser.uid,
      EcommerceApp.userEmail: currentUser.email,
      EcommerceApp.userName: _nameTextEditingController.text.trim(),
      EcommerceApp.userAvatarUrl: userImageUrl,
      EcommerceApp.userAvatarUrl: {"garbageValue"},
    });
    await EcommerceApp.sharedPreferences
        .setString(EcommerceApp.userUID, currentUser.uid);
    await EcommerceApp.sharedPreferences.setStringList(EcommerceApp.userCartList, ['garbageValue']);
    await EcommerceApp.sharedPreferences
        .setString(EcommerceApp.userEmail, currentUser.email);
    await EcommerceApp.sharedPreferences
        .setString(EcommerceApp.userName, _nameTextEditingController.text);
    await EcommerceApp.sharedPreferences
        .setString(EcommerceApp.userAvatarUrl, userImageUrl);
  }
}
