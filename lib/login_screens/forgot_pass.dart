import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/error_message.dart';
class password extends StatefulWidget {
  const password({Key? key}) : super(key: key);

  @override
  State<password> createState() => _passwordState();
}

class _passwordState extends State<password> {
  TextEditingController mail=TextEditingController();
  bool mal=true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
            Row(
              children: [
                SizedBox(width: 50,),
                Text('Reset Password',style: GoogleFonts.bubblegumSans(fontSize: 25,color: Colors.white)),
              ],
            ),
            SizedBox(height: 15,),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10),)
              ),
              width: 300,
              child:TextField(
                controller:mail,
                decoration: InputDecoration(

                  contentPadding: EdgeInsets.all(5),
                  border:OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                  hintText: "Enter registered Email id",
                  prefixIcon: Icon(Icons.alternate_email),
                  suffix: IconButton(
                      icon:Icon(Icons.clear_sharp),
                      onPressed:(){
                        setState(() {
                          mail=TextEditingController(text: "");
                        });
                      }
                  ),
                  hoverColor: Colors.white,


                ),

              ),
            ),
            SizedBox(height: 30,),
            FloatingActionButton.extended(
                    label: Text('send reset link to Mail',style: GoogleFonts.bubblegumSans(fontSize: 20,color: Colors.white)),
                    backgroundColor: Colors.indigo,
                    onPressed: ()async{
                        try{
                          await FirebaseAuth.instance.sendPasswordResetEmail(email: mail.text.trim());
                        } on FirebaseAuthException catch(e){
                          setState(() {
                            mal=false;
                          });
                          error(e.message.toString(), context);
                        }
                        if(mal){
                          error('Reset password link in sent to mail', context);
                        }


                    }
                )


          ],
        ),
        )
      ),

    );
  }
}
