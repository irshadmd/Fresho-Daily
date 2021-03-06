import 'package:email_validator/email_validator.dart';
import 'package:final_app/api/cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:progress_dialog/progress_dialog.dart';

class Checkout extends StatefulWidget {
  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  TextEditingController addressController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController pinController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  String paymentModeController = "Cash";

  final globalKey = GlobalKey<ScaffoldState>();
  ProgressDialog pr;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    pr = ProgressDialog(context,
        isDismissible: false,
        customBody: Container(
            color: Colors.transparent,
            child: SpinKitCubeGrid(
              color: Theme.of(context).accentColor,
            )));
    pr.style(
      backgroundColor: Colors.transparent,
    );
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        key: globalKey,
        appBar: AppBar(
          leading: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed('/Cart');
              },
              child: Icon(Icons.arrow_back)),
          actions: <Widget>[],
          backgroundColor: Colors.redAccent,
          elevation: 0,
          centerTitle: true,
          title: Text(
            "Checkout",
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
              color: Colors.white70,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  children: <Widget>[
                    Text(
                      "Enter Address",
                      style: GoogleFonts.roboto(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                      child: TextField(
                        controller: addressController,
                        keyboardType: TextInputType.text,
                        maxLines: 4,
                        decoration: InputDecoration(
                          labelText: "Address",
                          labelStyle: TextStyle(color: Colors.black87),
                          contentPadding: EdgeInsets.all(12),
                          hintText: 'Enter Address',
                          hintStyle:
                              TextStyle(color: Colors.black.withOpacity(0.7)),
                          prefixIcon: Icon(Icons.home, color: Colors.redAccent),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black.withOpacity(1))),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black.withOpacity(1))),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black.withOpacity(1))),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                      child: TextField(
                        controller: pinController,
                        keyboardType: TextInputType.number,
                        maxLines: 1,
                        decoration: InputDecoration(
                          labelText: "Pin",
                          labelStyle: TextStyle(color: Colors.black87),
                          contentPadding: EdgeInsets.all(12),
                          hintText: 'Enter you pin code',
                          hintStyle:
                              TextStyle(color: Colors.black.withOpacity(0.7)),
                          prefixIcon:
                              Icon(Icons.location_on, color: Colors.redAccent),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black.withOpacity(1))),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black.withOpacity(1))),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black.withOpacity(1))),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                      child: TextField(
                        controller: mobileController,
                        keyboardType: TextInputType.phone,
                        maxLines: 1,
                        decoration: InputDecoration(
                          labelText: "Mobile",
                          labelStyle: TextStyle(color: Colors.black87),
                          contentPadding: EdgeInsets.all(12),
                          hintText: 'Enter moile no',
                          hintStyle:
                              TextStyle(color: Colors.black.withOpacity(0.7)),
                          prefixIcon:
                              Icon(Icons.phone, color: Colors.redAccent),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black.withOpacity(1))),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black.withOpacity(1))),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black.withOpacity(1))),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                      child: TextField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        maxLines: 1,
                        decoration: InputDecoration(
                          labelText: "E-mail",
                          labelStyle: TextStyle(color: Colors.black87),
                          contentPadding: EdgeInsets.all(12),
                          hintText: 'Enter E-mail address',
                          hintStyle:
                              TextStyle(color: Colors.black.withOpacity(0.7)),
                          prefixIcon:
                              Icon(Icons.email, color: Colors.redAccent),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black.withOpacity(1))),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black.withOpacity(1))),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black.withOpacity(1))),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.payment,
                            color: Colors.redAccent,
                          ),
                          Text("Payment Mode"),
                          SizedBox(
                            width: 30,
                          ),
                          Container(
                            width: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.white70,
                              border: Border.all(),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                  value: paymentModeController,
                                  items: [
                                    DropdownMenuItem(
                                      child: Text("Cash"),
                                      value: "Cash",
                                    ),
                                    DropdownMenuItem(
                                      child: Text("Paynow"),
                                      value: "paynow",
                                    )
                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                      paymentModeController = value;
                                    });
                                  }),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
                      width: double.infinity,
                      height: 60,
                      child: RaisedButton.icon(
                        color: Colors.redAccent,
                        onPressed: () async {
                          if (addressController.text.toString() == "" &&
                                  pinController.text.toString() == "" ||
                              mobileController.text.toString() == "" ||
                              emailController.text.toString() == "") {
                            globalKey.currentState.showSnackBar(SnackBar(
                                backgroundColor: Theme.of(context)
                                    .focusColor
                                    .withOpacity(0.8),
                                content: Text(
                                  "Fill All Details",
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 10,
                                  ),
                                  textAlign: TextAlign.center,
                                )));
                          } else if (!EmailValidator.validate(
                              emailController.text)) {
                            globalKey.currentState.showSnackBar(SnackBar(
                                backgroundColor: Theme.of(context)
                                    .focusColor
                                    .withOpacity(0.8),
                                content: Text(
                                  "Invalid Email",
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 10,
                                  ),
                                  textAlign: TextAlign.center,
                                )));
                          } else {
                            pr.show();
                            await CartApi.orderPlacing(
                                    addressController.text.toString(),
                                    pinController.text.toString(),
                                    mobileController.text.toString(),
                                    emailController.text.toString(),
                                    paymentModeController.toString())
                                .then((value) {
                              pr.hide();

                              globalKey.currentState.showSnackBar(SnackBar(
                                  backgroundColor: Theme.of(context)
                                      .focusColor
                                      .withOpacity(0.8),
                                  content: Text(
                                    "$value",
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 10,
                                    ),
                                    textAlign: TextAlign.center,
                                  )));
                              if (value == "Order Placed") {
                                Navigator.of(context)
                                    .pushReplacementNamed('/OrderPlaced');
                              }
                            });
                          }
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            side: BorderSide(color: Colors.red)),
                        icon: Icon(
                          Icons.shopping_cart,
                          color: Colors.white,
                        ),
                        label: Text(
                          "Place Order",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
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
    Navigator.of(context).pushNamed('/Cart');
  }
}
