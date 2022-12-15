import 'dart:math';
import 'package:aves/widgets/custom_color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
class home_page extends StatefulWidget {
  home_page({Key? key,name}) : super(key: key);
  @override
  State<home_page> createState() => _home_pageState();
}

class _home_pageState extends State<home_page> with SingleTickerProviderStateMixin {
  String name="";
  late AnimationController animcon1;
  bool logo=false;
  var axisalign=MainAxisAlignment.start;
  double size=370;
  String mail="";

  @override
  void initState() {
    // TODO: implement initState
    animcon1=AnimationController(vsync: this,duration: Duration(seconds: 3));
    animate();
    setState(() {
      mail=FirebaseAuth.instance.currentUser!.email!;
    });
    FirebaseFirestore.instance.collection("UserData").doc(mail.toString()).get().then((value){
      value.data()?.forEach((key, value) {
        setState(() {
          name=value;
        });
      });
    });
    super.initState();
  }
  void animate(){

    animcon1.addStatusListener((status) {
      if(status==AnimationStatus.completed){
        // Navigator.pop(context);
        animcon1.reset();
        setState(() {
          logo=true;
          pos[index]=false;
        });
      }
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    animcon1.dispose();
    super.dispose();
  }
  List<bool> pos=[false,false,false,false,false,false,false,false];
  int index=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/sky1.jpg'),fit:BoxFit.cover)
        ),
          child:Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
            children: [

              if(logo)CircleAvatar(
                radius: 100,
                backgroundImage: AssetImage('assets/icon.png'),
              ),
              if(logo)SizedBox(height: 50,),
              if(logo) StreamBuilder<DocumentSnapshot>(
                        stream: FirebaseFirestore.instance.collection("UserData").doc(mail.toString()).snapshots(),
                        builder:(BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting)
                            return Center(child:CircularProgressIndicator(),);
                              Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                              return colorText(text:"Welcome\n${data['name']}",font: 45,colors: [Colors.cyan,Colors.cyan,Colors.blueAccent,],);
                            // }
                            },
              ),
              if(pos[0])SizedBox(height: 70,),
              if(pos[1])SizedBox(height:120 ,),
              if(pos[2])SizedBox(height: 170,),
              if(pos[3])SizedBox(height: 200 ,),
              if(pos[4])SizedBox(height: 250 ,),
              if(pos[5])SizedBox(height: 320 ,),
              if(pos[6])SizedBox(height: 370 ,),
              if(pos[7])SizedBox(height: 400 ,),
              if(!logo)Row(
                mainAxisAlignment: axisalign,
                children: [
                  if(pos[0]||pos[4])SizedBox(width: 10,),
                  if(pos[2]||pos[6])SizedBox(width: 75,),
                  Lottie.asset(
                      'assets/bird.json',
                      height: size,
                      width: size,
                      repeat: false,
                      controller: animcon1,
                    onLoaded: ((p0) => animcon1.forward())

                  ),
                  if(pos[1]||pos[5])SizedBox(width: 50,),
                  if(pos[3]||pos[7])SizedBox(width: 12,),
                ],
              )
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
      child: CircleAvatar(
          radius: 50,
          backgroundImage: AssetImage('assets/icon.png'),
        ),
        onPressed: ()async{
          // int index=1;

            setState(() {
              animcon1.reset();
              pos[index]=false;
              size=200;
              index=Random().nextInt(8);
              logo=false;
              pos[index]=true;
              animcon1.forward();
            });
            if(index==0||index==4||index==2||index==6){
              setState(() {
                axisalign=MainAxisAlignment.start;
              });
            }
            else{
              setState(() {
                axisalign=MainAxisAlignment.end;
              });
            }

            print(name);
        },
      ),

    );
  }
}
