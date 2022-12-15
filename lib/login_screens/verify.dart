import 'dart:async';
import 'package:aves/login_screens/signup.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:aves/home/home.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/error_message.dart';

class verify_mail extends StatefulWidget {
  const verify_mail({Key? key}) : super(key: key);

  @override
  State<verify_mail> createState() => _verify_mailState();
}

class _verify_mailState extends State<verify_mail> {
  bool vrfi=false;
  bool canresend=true;
  Timer? timer;
  String mail="";
  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      mail=FirebaseAuth.instance.currentUser!.email!;
    });
    vrfi=FirebaseAuth.instance.currentUser!.emailVerified;
    if(!vrfi){
      verifymail();
      timer=Timer.periodic(
        Duration(seconds: 2),
          (_)=>checkverify(),
      );
    }

    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    timer?.cancel();
    super.dispose();

  }
  @override
  Widget build(BuildContext context) => vrfi?home():
      Scaffold(
        body: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(fit: BoxFit.cover,image: AssetImage('assets/pass.jpg'))
            ),
            child:Center(
              child:Column(


                children: [
                  SizedBox(height: 150,),
                  Text("AVES",style:GoogleFonts.bubblegumSans(fontSize: 80,color:Colors.white) ),
                  SizedBox(height: 100,),
                  Text('An verification email is sent to your mail',style: GoogleFonts.bubblegumSans(fontSize: 25,color: Colors.white)),
                  SizedBox(height: 15,),
                  ElevatedButton.icon(style: ElevatedButton.styleFrom(minimumSize: Size(325, 45)),onPressed:canresend?verifymail:null, icon: Icon(Icons.email_outlined), label: Text('Resend Email',style: GoogleFonts.bubblegumSans(fontSize: 25,color: Colors.white))),
                  SizedBox(height: 30,),
                  ElevatedButton(style: ElevatedButton.styleFrom(minimumSize: Size(100, 35)),onPressed: ()=>FirebaseAuth.instance.currentUser!.delete(), child: Text("cancel",style: GoogleFonts.bubblegumSans(fontSize: 25,color: Colors.white))),
                ],
              ),
            )
        ),
      );

  Future verifymail() async{
    try{
      await FirebaseAuth.instance.currentUser!.sendEmailVerification();
      setState(() {canresend=false;});
      await Future.delayed(Duration(seconds: 7));
      setState(() {canresend=true;});
    } on FirebaseAuthException catch(e){
      error(e.message.toString(), context);
    }
  }

  Future checkverify() async{
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      vrfi=FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if(vrfi) {
      timer?.cancel();
      await FirebaseFirestore.instance.collection("UserData").doc(mail.toString()).set({"name":signup.username});
    }

  }
}


