import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Admin/adminLogin.dart';
import 'package:e_shop/Widgets/customTextField.dart';
import 'package:e_shop/DialogBox/errorDialog.dart';
import 'package:e_shop/DialogBox/loadingDialog.dart';
import 'package:e_shop/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../Store/storehome.dart';
import 'package:e_shop/Config/config.dart';
import 'package:e_shop/animation/FadeAnimation.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _nameTextEditingController =
      TextEditingController();
  final TextEditingController _emailTextEditingController =
      TextEditingController();
  final TextEditingController _passwordTextEditingController =
      TextEditingController();

  FirebaseUser firebaseUser;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String userImageUrl = "";

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    final width = MediaQuery.of(context).size.width;
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
                  color: Colors.orange,
                ),
              ),
              Container(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [],
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
                                    controller: _emailTextEditingController,
                                    data: Icons.person,
                                    hintText: "Email",
                                    isObsecure: false),
                                CustomTextField(
                                    controller: _passwordTextEditingController,
                                    data: Icons.person,
                                    hintText: "password",
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
                              color: Colors.purple[200],
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)),
                              onPressed: () {
                                _emailTextEditingController.text.isNotEmpty &&
                                        _passwordTextEditingController
                                            .text.isNotEmpty
                                    ? loginUser()
                                    : showDialog(
                                        context: context,
                                        builder: (c) {
                                          return ErrorAlertDialog(
                                              message:
                                                  "please write Email and Password!!!");
                                        });
                              },
                              child: Text(
                                "Login",
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
                            color: Colors.purple[200],
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AdminSignInPage()));
                            },
                            child: Text(
                              "Sign up",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  FirebaseAuth _auth = FirebaseAuth.instance;

  void loginUser() async {
    showDialog(
      context: context,
      builder: (c) {
        return LoadingAlertDialog(message: "Loading , Please Wait...");
      },
    );
    FirebaseUser currentUser;
    await _auth
        .signInWithEmailAndPassword(
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
      readDataToDataBase(currentUser).then((s) {
        Navigator.pop(context);
        Route newRoute = MaterialPageRoute(builder: (_) => StoreHome());
        Navigator.pushReplacement(context, newRoute);
      });
    } else {
      Fluttertoast.showToast(msg: "user is not logged-in");
    }
  }

  Future readDataToDataBase(FirebaseUser currentUser) async {
    await EcommerceApp.firestore
        .collection(EcommerceApp.collectionUser)
        .document(currentUser.uid)
        .get()
        .then((snapshot) async {
      print(snapshot.data);
      await EcommerceApp.sharedPreferences
          .setString(EcommerceApp.userUID, snapshot.data[EcommerceApp.userUID]);
      await EcommerceApp.sharedPreferences.setString(
          EcommerceApp.userEmail, snapshot.data[EcommerceApp.userEmail]);
      await EcommerceApp.sharedPreferences.setString(
          EcommerceApp.userName, snapshot.data[EcommerceApp.userName]);
      await EcommerceApp.sharedPreferences.setString(EcommerceApp.userAvatarUrl,
          snapshot.data[EcommerceApp.userAvatarUrl]);
      print(snapshot.data[EcommerceApp.userCartList]);
      List<String> cart =
          snapshot.data[EcommerceApp.userCartList].cast<String>();
      await EcommerceApp.sharedPreferences
          .setStringList(EcommerceApp.userCartList, cart);
    });
  }
}
