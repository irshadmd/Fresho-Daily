import 'package:auto_size_text/auto_size_text.dart';
import 'package:final_app/api/cart.dart';
import 'package:final_app/models/OrderData.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class OrderItemWidget extends StatefulWidget {
  final OrderData cartData;

  const OrderItemWidget({this.cartData});

  @override
  _OrderItemWidgetState createState() => _OrderItemWidgetState();
}

class _OrderItemWidgetState extends State<OrderItemWidget> {
  bool _emptyCart = false;
  List<OrderData> productApi = new List<OrderData>();

  void getCouponList() async {
    await CartApi.myOrders().then((value) {
      if (mounted) {
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
        }
      } else if (value is String) {
        print(value);
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
    return Container(
      margin: EdgeInsets.all(10),
      height: 160,
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
                            "Order id : ${widget.cartData.id.toString()}",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
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
                            "Order Date ",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style:
                                TextStyle(fontSize: 20.0, color: Colors.black),
                          ),
                          Text(
                            "${widget.cartData.date_placed.toString()}",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style:
                                TextStyle(fontSize: 15.0, color: Colors.black),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: <Widget>[
                          Text(
                            "Total Amount :",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style:
                                TextStyle(fontSize: 20.0, color: Colors.black),
                          ),
                          Text(
                            "${widget.cartData.total.toString()}",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style:
                                TextStyle(fontSize: 20.0, color: Colors.black),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: <Widget>[
                          Text(
                            "Order Status :",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style:
                                TextStyle(fontSize: 20.0, color: Colors.black),
                          ),
                          Text(
                            "${widget.cartData.order_status.toString()}",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style:
                                TextStyle(fontSize: 20.0, color: Colors.black),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
