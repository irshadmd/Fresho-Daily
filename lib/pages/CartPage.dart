import 'package:final_app/Helper/CartItemWidget.dart';
import 'package:final_app/api/cart.dart';
import 'package:final_app/models/Cart.dart';
import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  int currentTab = 3;

  Cart({Key key, this.currentTab}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  final globalKey = GlobalKey<ScaffoldState>();
  String message = "";
  bool _emptyCart = false;
  List<CartData> productApi = new List<CartData>();

  void getCouponList() async {
    await CartApi.cartList().then((value) {
      if (value is List) {
        setState(() {
          productApi = value;
          print("=+++++++++++++++++++++++++++======");
          print(productApi.length);
          print("=========== Product Api=========");
          print(productApi.toString());
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

  int totalAmount = 0;

  void getTotalAmount() async {
    await CartApi.totalAmount().then((value) {
      if (value > 0) {
        setState(() {
          totalAmount = value;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    print("====Trending Now==============");
    getCouponList();
    getTotalAmount();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController couponController = new TextEditingController();
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
          actions: <Widget>[
            Column(
              children: <Widget>[
                IconButton(
                    icon: Icon(
                      Icons.remove_shopping_cart,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      CartApi.deleteCart();
                      setState(() {
                        this._emptyCart = true;

                        // productApi.length=0;
                      });
                    }),
              ],
            )
          ],
          backgroundColor: Colors.redAccent,
          elevation: 0,
          centerTitle: true,
          title: Text(
            "My Cart",
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
                                      return CartItemWidget(
                                        cartData: productApi[index],
                                      );
                                    },
                                  ),
                                  Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 15),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        children: <Widget>[
                                          Divider(
                                            height: 60.0,
                                            color: Colors.grey[700],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        20.0, 0, 20.0, 0),
                                                child: Text(
                                                  "Subtotal ",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                    fontSize: 20.0,
                                                    color: Colors.black,
                                                    fontStyle: FontStyle.italic,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        20.0, 0, 20.0, 0),
                                                child: Text(
                                                  "\u20B9 $totalAmount",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                    fontSize: 20.0,
                                                    color: Colors.black,
                                                    fontStyle: FontStyle.italic,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        20.0, 0, 20.0, 0),
                                                child: Text(
                                                  "Shipping",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                    fontSize: 20.0,
                                                    color: Colors.black,
                                                    fontStyle: FontStyle.italic,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        20.0, 0, 20.0, 0),
                                                child: Text(
                                                  "Free shipping",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                    fontSize: 20.0,
                                                    color: Colors.black,
                                                    fontStyle: FontStyle.italic,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Divider(
                                            height: 20.0,
                                            color: Colors.grey[700],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(20.0),
                                                child: Text(
                                                  "Total ",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                    fontSize: 20.0,
                                                    color: Colors.black,
                                                    fontStyle: FontStyle.italic,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(20.0),
                                                child: Text(
                                                  "\u20B9 $totalAmount",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                    fontSize: 20.0,
                                                    color: Colors.black,
                                                    fontStyle: FontStyle.italic,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            width: double.infinity,
                                            height: 60,
                                            child: RaisedButton.icon(
                                              color: Colors.redAccent,
                                              onPressed: () {
                                                Navigator.of(context)
                                                    .pushNamed('/Checkout');
                                              },
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          25.0),
                                                  side: BorderSide(
                                                      color: Colors.red)),
                                              icon: Icon(
                                                Icons.shopping_cart,
                                                color: Colors.white,
                                              ),
                                              label: Text(
                                                "Checkout",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          )
                                        ],
                                      )),
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
