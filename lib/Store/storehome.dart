import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Store/cart.dart';
import 'package:e_shop/Store/product_page.dart';
import 'package:e_shop/Counters/cartitemcounter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:e_shop/Config/config.dart';
import '../Widgets/loadingWidget.dart';
import '../Widgets/myDrawer.dart';
import '../Widgets/searchBox.dart';
import '../Models/item.dart';


double width;

class StoreHome extends StatefulWidget {
  @override
  _StoreHomeState createState() => _StoreHomeState();
}

class _StoreHomeState extends State<StoreHome> {
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
  backgroundColor:  Color(0xFF035AA6),
        appBar: AppBar(
          backgroundColor: Color(0xFF035AA6),
          title: Text('Cano_eshop'),
          centerTitle: false,
          actions: [
            Stack(
              children: [
                IconButton(
                  icon: Icon(Icons.shopping_basket),
                  onPressed: () {
                    Route route = MaterialPageRoute(builder: (c) => CartPage());
                    Navigator.pushReplacement(context, route);
                  },
                ),
                Positioned(
                    child: Stack(children: [
                  Icon(
                    Icons.brightness_1,
                    size: 20.0,
                    color: Colors.green,
                  ),
                  Positioned(
                    top: 3.0,
                    bottom: 4.0,
                    child: Consumer<CartItemCounter>(
                        builder: (context, counter, _) {
                      style:
                      TextStyle(fontSize: 17.0, fontWeight: FontWeight.w500);
                    }),
                  ),
                ]))
              ],
            ),
          ],
        ),
        drawer: Drawer(
          child: new ListView(
            children: <Widget>[
              new UserAccountsDrawerHeader(

                accountName: new Text(EcommerceApp.sharedPreferences.getString(EcommerceApp.userName),
                style:TextStyle(color:Colors.black,fontSize: 37.0,fontFamily: "Signatra"),
                ),
                accountEmail: new Text(EcommerceApp.sharedPreferences.getString(EcommerceApp.userEmail),
                  style:TextStyle(color:Colors.black,fontSize: 20.0,fontFamily: "Signatra"),
                ),
                currentAccountPicture: Container(
                  child: new CircleAvatar(
                    backgroundImage: NetworkImage(
                      EcommerceApp.sharedPreferences.getString(EcommerceApp.userAvatarUrl),
                    ),
                  ),
                ),

              ),
              new ListTile(
                title: new Text("data"),
                trailing: new Icon(Icons.arrow_upward),
              ),
              new Divider(),
              new ListTile(
                title: new Text("data"),
                trailing: new Icon(Icons.arrow_upward),
              ),
              new Divider(),
              new ListTile(
                title: new Text("data"),
                trailing: new Icon(Icons.arrow_upward),
              ),
              new Divider(),
              new ListTile(
                title: new Text("data"),
                trailing: new Icon(Icons.arrow_upward),
              ),
              new Divider(),
              new ListTile(
                title: new Text("data"),
                trailing: new Icon(Icons.arrow_upward),
              ),
              new ListTile(
                title: new Text("data"),
                trailing: new Icon(Icons.arrow_upward),
              ),
              new Divider(),
              new ListTile(
                title: new Text("data"),
                trailing: new Icon(Icons.arrow_upward),
              ),
              new ListTile(
                title: new Text("data"),
                trailing: new Icon(Icons.arrow_upward),
              ),
            ],
          ),
        ),
        body: new Container(
          child: new Center(
            child: new Text("Home PAge"),
          ),
        ),
      ),
    );
  }
}

Widget sourceInfo(ItemModel model, BuildContext context,
    {Color background, removeCartFunction}) {
  return InkWell();
}

Widget card({Color primaryColor = Colors.redAccent, String imgPath}) {
  return Container();
}

void checkItemInCart(String productID, BuildContext context) {}
