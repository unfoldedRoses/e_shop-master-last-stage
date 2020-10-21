import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Address/addAddress.dart';
import 'package:e_shop/Authentication/authenication.dart';
import 'package:e_shop/Orders/myOrders.dart';
import 'package:e_shop/Store/Search.dart';
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
        backgroundColor: Color(0xFF21BFBD),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.0),
          child: AppBar(
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: <Color>[Colors.deepPurpleAccent, Colors.blue])),
            ),
            brightness: Brightness.light,
            backgroundColor: Color(0xFF21BFBD),
            title: Text('Cano_eshop'),
            centerTitle: false,
            actions: [
              Stack(
                children: [
                  IconButton(
                    icon: Icon(Icons.shopping_basket),
                    onPressed: () {
                      Route route =
                          MaterialPageRoute(builder: (c) => CartPage());
                      Navigator.pushReplacement(context, route);
                    },
                  ),
                  Positioned(
                      child: Stack(children: [
                    Icon(
                      Icons.brightness_1,
                      size: 20.0,
                      color: Colors.white,
                    ),
                    Positioned(
                      top: 3.0,
                      bottom: 4.0,
                      left: 3.0,
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
        ),
        drawer: Drawer(
          child: new ListView(
            children: <Widget>[
              new UserAccountsDrawerHeader(
                accountName: new Text(
                  EcommerceApp.sharedPreferences
                      .getString(EcommerceApp.userName),
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 37.0,
                      fontFamily: "Signatra"),
                ),
                accountEmail: new Text(
                  EcommerceApp.sharedPreferences
                      .getString(EcommerceApp.userEmail),
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontFamily: "Signatra"),
                ),
                currentAccountPicture: Container(
                  child: new CircleAvatar(
                    backgroundImage: NetworkImage(
                      EcommerceApp.sharedPreferences
                          .getString(EcommerceApp.userAvatarUrl),
                    ),
                  ),
                ),
              ),
              new ListTile(
                  title: new Text("Home"),
                  trailing: new Icon(Icons.home),
                  onTap: () {
                    Route newRoute =
                        MaterialPageRoute(builder: (_) => StoreHome());
                    Navigator.pushReplacement(context, newRoute);
                  }),
              new ListTile(
                  title: new Text("Search"),
                  trailing: new Icon(Icons.search),
                  onTap: () {
                    Route newRoute =
                        MaterialPageRoute(builder: (_) => SearchProduct());
                    Navigator.pushReplacement(context, newRoute);
                  }),
              new Divider(),
              new ListTile(
                  title: new Text("Add New Address"),
                  trailing: new Icon(Icons.location_city),
                  onTap: () {
                    Route newRoute =
                        MaterialPageRoute(builder: (_) => AddAddress());
                    Navigator.pushReplacement(context, newRoute);
                  }),
              new Divider(),
              new ListTile(
                  title: new Text("My Orders"),
                  trailing: new Icon(Icons.featured_play_list),
                  onTap: () {
                    Route newRoute =
                        MaterialPageRoute(builder: (_) => MyOrders());
                    Navigator.pushReplacement(context, newRoute);
                  }),
              new Divider(),
              new ListTile(
                  title: new Text("My Cart"),
                  trailing: new Icon(Icons.shopping_cart),
                  onTap: () {
                    Route newRoute =
                        MaterialPageRoute(builder: (_) => CartPage());
                    Navigator.pushReplacement(context, newRoute);
                  }),
              new Divider(),
              new ListTile(
                  title: new Text("Log Me Out!"),
                  trailing: new Icon(Icons.arrow_upward),
                  onTap: () {
                    EcommerceApp.auth.signOut().then((c) {
                      Route route =
                          MaterialPageRoute(builder: (c) => AuthenticScreen());
                      Navigator.pushReplacement(context, route);
                    });
                  }),
            ],
          ),
        ),
        body: CustomScrollView(slivers: [
          StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance
                  .collection("items")
                  .limit(2)
                  .orderBy("publishedDate", descending: true)
                  .snapshots(),
              builder: (context, dataSnapshot) {
                return !dataSnapshot.hasData
                    ? SliverToBoxAdapter(
                        child: Center(
                          child: circularProgress(),
                        ),
                      )
                    : SliverStaggeredGrid.countBuilder(
                        crossAxisCount: 1,
                        staggeredTileBuilder: (c) => StaggeredTile.fit(1),
                        itemBuilder: (context, index) {
                          ItemModel model = ItemModel.fromJson(
                              dataSnapshot.data.documents[index].data);
                          return sourceInfo(model, context);
                        },
                        itemCount: dataSnapshot.data.documents.length,
                      );
              })
        ]),
      ),
    );
  }
}

Widget sourceInfo(ItemModel model, BuildContext context,
    {Color background, removeCartFunction}) {
  return InkWell(
    child: Container(
      padding: EdgeInsets.all(6),
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.2),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          bottomLeft: Radius.circular(12),
        ),
      ),
      child: Row(
        children: <Widget>[
          Image.network(model.thumbnailUrl),
          SizedBox(width: 16),
          Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(height: 15.0),
              Container(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                        child: Text(
                      model.title,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                      ),
                    ))
                  ],
                ),
              ),
              SizedBox(height: 5.0),
              Container(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                        child: Text(
                      model.shortInfo,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                      ),
                    ))
                  ],
                ),
              ),
            ]),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 4),
              Row(
                children: <Widget>[
                  SizedBox(width: 16),
                ],
              ),
            ],
          )
        ],
      ),
    ),
  );
}

Widget card({Color primaryColor = Colors.redAccent, String imgPath}) {
  return Container();
}

void checkItemInCart(String productID, BuildContext context) {}
