import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderPlaced extends StatefulWidget {
  @override
  _OrderPlacedState createState() => _OrderPlacedState();
}

class _OrderPlacedState extends State<OrderPlaced> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed('/MainPage');
              },
              child: Icon(Icons.arrow_back)),
          actions: <Widget>[],
          backgroundColor: Colors.redAccent,
          elevation: 0,
          centerTitle: true,
          title: Text(
            "Order Placed",
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image(
                      image: AssetImage('assets/placed.png'),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      height: 60,
                      child: RaisedButton.icon(
                        color: Colors.redAccent,
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacementNamed('/MainPage');
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            side: BorderSide(color: Colors.red)),
                        icon: Icon(
                          Icons.home,
                          color: Colors.white,
                        ),
                        label: Text(
                          "Home",
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
    Navigator.of(context).pushNamed('/MainPage');
  }
}
