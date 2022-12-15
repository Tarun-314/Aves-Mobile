import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
void error(String msg,context){
  ScaffoldMessenger.of(context)
    ..removeCurrentSnackBar()
    ..showSnackBar(
        SnackBar(
          content: Text(
            msg,
            style: GoogleFonts.bubblegumSans(fontSize: 20,color: Colors.white),
          ),
          backgroundColor: Colors.red,
          shape: StadiumBorder(),
          margin: EdgeInsets.only(left:3 ,right:3,bottom: 5 ),
          elevation: 7,
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 3),

        )
    );
}