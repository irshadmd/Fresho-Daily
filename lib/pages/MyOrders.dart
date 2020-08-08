import 'package:final_app/Helper/OrderItemWidget.dart';
import 'package:final_app/api/cart.dart';
import 'package:final_app/models/OrderData.dart';
import 'package:flutter/material.dart';

class MyOrders extends StatefulWidget {
  int currentTab = 3;

  MyOrders({Key key, this.currentTab}) : super(key: key);

  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  final globalKey = GlobalKey<ScaffoldState>();
  String message = "";
  bool _emptyCart = false;
  List<OrderData> productApi = new List<OrderData>();

  void getCouponList() async {
    await CartApi.myOrders().then((value) {
      if (value is List) {
        setState(() {
          productApi = value;
          if (value.length == 0) {
            setState(() {
              this._emptyCart = true;
            });
          } else {
            setState(() {
              productApi = value;
            });
          }
        });
      } else if (value is String) {
        setState(() {
          message = value;
          print(message);
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getCouponList();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        key: globalKey,
        appBar: AppBar(
          leading: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed('/MainPage');
              },
              child: Icon(Icons.arrow_back)),
          backgroundColor: Colors.redAccent,
          elevation: 0,
          centerTitle: true,
          title: Text(
            "My Orders",
            style: Theme.of(context)
                .textTheme
                .headline6
                .merge(TextStyle(letterSpacing: 1.3, color: Colors.white)),
          ),
        ),
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(bottom: 15),
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    productApi.length == 0
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : this._emptyCart
                            ? Image.asset('assets/emptycart.png')
                            : Column(
                                children: <Widget>[
                                  ListView.separated(
                                    padding: EdgeInsets.symmetric(vertical: 15),
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    primary: false,
                                    itemCount: productApi.length,
                                    separatorBuilder: (context, index) {
                                      return SizedBox(height: 15);
                                    },
                                    itemBuilder: (context, index) {
                                      return OrderItemWidget(
                                        cartData: productApi[index],
                                      );
                                    },
                                  ),
                                ],
                              ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _onBackPressed() {
    Navigator.of(context).pushNamed('/MainPage');
  }
}
