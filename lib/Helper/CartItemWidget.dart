import 'package:auto_size_text/auto_size_text.dart';
import 'package:final_app/api/cart.dart';
import 'package:final_app/models/AllProducts.dart';
import 'package:final_app/models/Cart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class CartItemWidget extends StatefulWidget {
  final CartData cartData;

  const CartItemWidget({this.cartData});

  @override
  _CartItemWidgetState createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  bool _emptyCart = false;
  List<CartData> productApi = new List<CartData>();

  void getCouponList() async {
    await CartApi.cartList().then((value) {
      if (mounted) {
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
        }
      } else if (value is String) {
        print(value);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    print("====Trending Now==============");
    getCouponList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      height: 140,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
              color: Color(0xffB9CCFC), blurRadius: 5, offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            height: 60,
            width: 60,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Color(0xffB9CCFC),
                      blurRadius: 5,
                      offset: Offset(0, 2)),
                ],
                image: DecorationImage(
                    image: NetworkImage(
                        'https://freshodaily.com/${widget.cartData.image.toString()}'),
                    fit: BoxFit.cover)),
          ),
          SizedBox(width: 15),
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        width: 120,
                        height: 30,
                        child: AutoSizeText(
                            "${widget.cartData.productName.toString()}",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: GoogleFonts.raleway(
                              fontSize: 20.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: <Widget>[
                          Text(
                            "Quantity : ",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style:
                                TextStyle(fontSize: 20.0, color: Colors.black),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                CartApi.updateCartItemByIdSub(
                                        widget.cartData.id.toString(),
                                        widget.cartData.quantity.toString())
                                    .then((value) => Navigator.of(context)
                                        .pushNamed('/Cart'));
                              });
                            },
                            icon: Icon(
                              Icons.remove_circle_outline,
                              color: Colors.blue,
                            ),
                          ),
                          Text(
                            "${widget.cartData.quantity.toString()}",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style:
                                TextStyle(fontSize: 20.0, color: Colors.black),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                CartApi.updateCartItemByIdAdd(
                                        widget.cartData.id.toString(),
                                        widget.cartData.quantity.toString())
                                    .then((value) => Navigator.of(context)
                                        .pushNamed('/Cart'));
                              });
                            },
                            icon: Icon(
                              Icons.add_circle_outline,
                              color: Colors.blue,
                            ),
                          )
                        ],
                      ),
                      Text(
                        "Price               " +
                            "\u20B9 ${widget.cartData.rate.toString()} /${widget.cartData.measurementUnit.toString()}",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      setState(() {
                        CartApi.deleteCartItemById(
                                widget.cartData.id.toString())
                            .then((value) => print(value));
                        Navigator.of(context).pushNamed('/Cart');
                      });
                    }),
                SizedBox(width: 8),
              ],
            ),
          )
        ],
      ),
    );
  }
}
