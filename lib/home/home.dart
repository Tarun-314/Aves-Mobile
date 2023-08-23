import 'package:aves/home_screens/home_screen.dart';
import 'package:aves/home_screens/image_srch.dart';
import 'package:aves/home_screens/search.dart';
import 'package:aves/home_screens/settings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
class home extends StatefulWidget {
  home({Key? key}) : super(key: key);
  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home>{
  int _selectedIndex = 0;
  String mail="";
  List<Widget> _widgetOptions = <Widget>[      //this is the one which maps with the index
    home_page(),
    search_img_page(),      //home_screens/seach.dart
    search_page(),
    settings_page(),
  ];
  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      mail=FirebaseAuth.instance.currentUser!.email!;
    });
    Future.delayed(Duration(seconds:1),() =>popup(context) ,);

    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        title: ShaderMask(
            shaderCallback: (rect)=>LinearGradient(
                colors: [
                  Colors.lightBlue,
                  Colors.cyanAccent,
                ]
            ).createShader(rect),
          child: Text("AVES",style:GoogleFonts.bubblegumSans(fontSize: 70,color:Colors.white,) ),
        ),
        centerTitle: true,

        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.lightBlueAccent,
                    Colors.white,

                  ]
              ),
          ),
        ),

      ),
      body:IndexedStack(
          index:_selectedIndex,
          children: _widgetOptions,
        ),




      bottomNavigationBar:Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.lightBlueAccent,
                  Colors.white,

                ]
            ),
          ),

        child: SafeArea(
        child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
        child: GNav(

        rippleColor: Colors.indigoAccent,
        hoverColor: Colors.indigoAccent,
        gap: 5,

        iconSize: 25,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        duration: Duration(milliseconds: 400),


        tabs: [
        GButton(
        icon:Icons.home,

        text: 'Home',
          backgroundGradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Colors.blueAccent,
                Colors.lightBlue,

              ]

          ),
          iconSize: 26,
          iconColor: Colors.black,
          textColor: Colors.white,
          iconActiveColor: Colors.white,
        ),
        GButton(
        icon: Icons.image_search,
        text: 'Image search',
          backgroundGradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Colors.blueAccent,
                Colors.lightBlue,

              ]

          ),
          iconSize: 26,
          iconColor: Colors.black,
          textColor: Colors.white,
          iconActiveColor: Colors.white,
        ),
        GButton(
        icon: Icons.search,
        text: 'Name Search',
          backgroundGradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Colors.blueAccent,
                Colors.lightBlue,

              ]

          ),
          iconSize: 26,
          iconColor: Colors.black,
          textColor: Colors.white,
          iconActiveColor: Colors.white,
        ),
        GButton(
        icon: Icons.settings,
        text: 'Settings',
          backgroundGradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Colors.blueAccent,
                Colors.lightBlue,

              ]

          ),
          iconColor: Colors.black,
          textColor: Colors.white,
          iconActiveColor: Colors.white,
          iconSize: 26,
        ),
        ],
        selectedIndex: _selectedIndex,
        onTabChange: (index) {
          FocusManager.instance.primaryFocus?.unfocus();
          setState(() {
          _selectedIndex = index;
          });
        },
        ),
          ),
        ),
        ),
    );
  }

  void popup(context) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(

            content: Text(
              'Signed in as $mail',
              style: GoogleFonts.bubblegumSans(fontSize: 20,color: Colors.black),
            ),
            backgroundColor: Colors.white,
          elevation: 4,
          shape: StadiumBorder(),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(left:10,right:10,bottom: 5 ),
          duration: Duration(seconds: 1),
        )
      );
    // Fluttertoast.showToast(msg:'Signed in as $mail' ,fontSize: 13,backgroundColor: Colors.black);
  }


}
