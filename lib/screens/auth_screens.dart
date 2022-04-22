import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop_app/widgets/auth_card.dart';

class AuthMode extends StatelessWidget {
  static const routeName = "/auth";
  const AuthMode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(
      children: [
        //backgroud color using linear gradient
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                Color.fromRGBO(250, 250, 250, 1.0).withOpacity(0.5),
                Color.fromRGBO(255, 176, 152, 1.0).withOpacity(0.9)
                /*Colors.blue,
                  Colors.red*/
              ],
                  stops: [
                0,
                1
              ])),
        ),

        SingleChildScrollView(
          child: Container(
            height: deviceSize.height,
            width: deviceSize.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(

                  child: Container(

                    margin: EdgeInsets.only(bottom: 20),
                    padding: EdgeInsets.symmetric(vertical: 8,horizontal: 94),
                    transform: Matrix4.rotationZ(-6*pi /180)..translate(-10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.deepOrange.shade900,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 8,
                          color: Colors.black26,
                          offset: Offset(0, 2),
                        )
                      ]
                    ),
                    child: Text("MyShop",style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      fontSize: 50,
                      fontFamily: 'Trajan'
                    ),),
                  ),
                ),

                Flexible(
                    flex: deviceSize.width > 600 ? 2 : 1,
                    child: AuthCard(),)
              ],
            ),
          ),
        )
      ],
    ));
  }
}
