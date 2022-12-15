
import 'package:aves/login_screens/forgot_pass.dart';
import 'package:aves/widgets/error_message.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
class signin extends StatefulWidget {
  final VoidCallback chSignup;
  const signin({Key? key,required this.chSignup}) : super(key: key);


  @override
  State<signin> createState() => _signinState();
}

class _signinState extends State<signin> {
  TextEditingController email=TextEditingController();
  TextEditingController pwd=TextEditingController();
  String st='assets/signin.jpg';
  bool pass=true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height:MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                image: DecorationImage(fit: BoxFit.cover,image: AssetImage(st))
            ),
          ),
          SingleChildScrollView(
            child:
            Container(
              height: MediaQuery.of(context).size.height,
              child:Center(
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,

                  children: [
                    Text("AVES",style:GoogleFonts.bubblegumSans(fontSize: 80,color:Colors.white) ),
                    SizedBox(height: 100,),
                    Container(
                      width: 300,
                      decoration: BoxDecoration(color: Colors.white38,borderRadius: BorderRadius.all(Radius.circular(10))),
                      child:TextField(
                        controller:email,
                        textInputAction: TextInputAction.next,
                        onSubmitted: (_) => FocusScope.of(context).nextFocus(),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(5),
                          border:OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                          hintText: "Email",
                          prefixIcon: Icon(Icons.alternate_email),
                          suffix: IconButton(
                              icon:Icon(Icons.clear_sharp),
                              onPressed:(){
                                setState(() {
                                  email=TextEditingController(text: "");
                                });
                              }
                          ),

                          hoverColor: Colors.black,
                          label: Text("Email"),
                        ),

                      ),
                    ),
                    SizedBox(height: 30,),
                    Container(
                      width: 300,
                      decoration: BoxDecoration(color: Colors.white38,borderRadius: BorderRadius.all(Radius.circular(10))),
                      child:TextField(
                        textInputAction: TextInputAction.done,
                        onSubmitted: (_) => FocusScope.of(context).unfocus(),
                        obscureText: pass,
                        controller:pwd,
                        decoration: InputDecoration(
                          hoverColor: Colors.cyan,
                          contentPadding: EdgeInsets.all(5),
                          border:OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                          hintText: "Password",

                          prefixIcon: Icon(Icons.password),
                          label: Text("Password"),
                          suffix: IconButton(
                              icon:pass==false?Icon(Icons.key_off):Icon(Icons.key),
                              onPressed:(){
                                setState(() {
                                  pass=!pass;
                                });
                              }
                          ),

                        ),

                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => password(),));
                            },
                            child:Text("Forgot password?",style:GoogleFonts.bubblegumSans(fontSize: 20,color:Colors.white,decoration: TextDecoration.underline),)

                        ),
                        SizedBox(width: 40,)
                      ],
                    ),
                    SizedBox(height: 10,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [

                        Text("Sign in",
                          style: GoogleFonts.bubblegumSans(fontSize: 40,color: Colors.white),
                        ),
                        SizedBox(width: 140,),
                        FloatingActionButton(
                            onPressed: ()async{
                              try{
                                await FirebaseAuth.instance.signInWithEmailAndPassword(
                                    email: email.text.trim(),
                                    password: pwd.text.trim()
                                );
                              } on FirebaseAuthException catch(e){
                                error(e.message.toString(), context);
                              }
                            },
                            child: Icon(Icons.arrow_forward)
                        ),
                        SizedBox(width: 40,)
                      ],
                    ),
                    SizedBox(height: 50,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an Account?",style: GoogleFonts.bubblegumSans(fontSize: 25,color: Colors.white)),
                        TextButton(
                            onPressed:widget.chSignup,

                            child: Text("SignUp",style: GoogleFonts.bubblegumSans(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white,decoration: TextDecoration.underline),))
                      ],
                    ),
                    SizedBox(height: 80,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage('assets/icon.png'),
                        ),
                        SizedBox(width: 10,)
                      ],
                    ),
                    SizedBox(height:20 ,)
                  ],
                ),
              ),
            ),
          ),
        ],
      )
    );
  }
}
