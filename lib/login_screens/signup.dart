import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/error_message.dart';
class signup extends StatefulWidget {
  final Function() chSignin;

  static String username="";
  const signup({Key? key,required this.chSignin}) : super(key: key);

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  TextEditingController email1=TextEditingController();
  TextEditingController pwd1=TextEditingController();
  TextEditingController pwd2=TextEditingController();
  TextEditingController name=TextEditingController();
  bool pass1=true;
  bool pass2=true;
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
                image: DecorationImage(fit: BoxFit.cover,image: AssetImage('assets/signup.jpg'))
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
                    SizedBox(height: 120,),
                    Container(
                      width: 300,
                      decoration: BoxDecoration(color: Colors.white38,borderRadius: BorderRadius.all(Radius.circular(10))),
                      child:TextField(
                        controller:email1,
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
                                  email1=TextEditingController(text: "");
                                });
                              }
                          ),
                          hoverColor: Colors.black,
                          label: Text("Email"),
                        ),

                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      decoration: BoxDecoration(color: Colors.white38,borderRadius: BorderRadius.all(Radius.circular(10))),
                      width: 300,
                      child:TextField(
                        controller:name,
                        textInputAction: TextInputAction.next,
                        onChanged: (val){
                          setState(() {
                            signup.username=val;
                          });
                        },
                        onSubmitted: (_) => FocusScope.of(context).nextFocus(),
                        decoration: InputDecoration(

                          contentPadding: EdgeInsets.all(5),
                          border:OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                          hintText: "User Name",
                          prefixIcon: Icon(Icons.person),
                          suffix: IconButton(
                              icon:Icon(Icons.clear_sharp),
                              onPressed:(){
                                setState(() {
                                  name=TextEditingController(text: "");
                                });
                              }
                          ),
                          hoverColor: Colors.black,
                          label: Text("User Name"),
                        ),

                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      width: 300,
                      decoration: BoxDecoration(color: Colors.white38,borderRadius: BorderRadius.all(Radius.circular(10))),
                      child:TextField(
                        obscureText: pass1,
                        controller:pwd1,
                        textInputAction: TextInputAction.next,
                        onSubmitted: (_) => FocusScope.of(context).nextFocus(),
                        decoration: InputDecoration(
                          hoverColor: Colors.cyan,
                          contentPadding: EdgeInsets.all(5),
                          border:OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                          hintText: "Password",

                          prefixIcon: Icon(Icons.password),
                          label: Text("Password"),
                          suffix: IconButton(
                              icon:pass1==false?Icon(Icons.key_off):Icon(Icons.key),
                              onPressed:(){
                                setState(() {
                                  pass1=!pass1;
                                });
                              }
                          ),

                        ),

                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      width: 300,
                      decoration: BoxDecoration(color: Colors.white38,borderRadius: BorderRadius.all(Radius.circular(10))),
                      child:TextField(
                        obscureText: pass2,
                        controller:pwd2,
                        textInputAction: TextInputAction.done,
                        onSubmitted: (_) => FocusScope.of(context).unfocus(),
                        decoration: InputDecoration(
                          hoverColor: Colors.cyan,
                          contentPadding: EdgeInsets.all(5),
                          border:OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                          hintText: "Confirm Password",

                          prefixIcon: Icon(Icons.password),
                          label: Text("Confirm Password"),
                          suffix: IconButton(
                              icon:pass2==false?Icon(Icons.key_off):Icon(Icons.key),
                              onPressed:(){
                                setState(() {
                                  pass2=!pass2;
                                });
                              }
                          ),

                        ),

                      ),
                    ),
                    SizedBox(height: 20,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [

                        Text("Sign up",
                          style: GoogleFonts.bubblegumSans(fontSize: 40,color: Colors.black),
                        ),
                        SizedBox(width: 140,),
                        FloatingActionButton(
                            onPressed: ()async{
                              if(pwd1.text!=pwd2.text){
                                error("Password doesnot match", context);
                              }
                              else if(name.text!=""&&name.text.length>=6){
                                try{
                                  await FirebaseAuth.instance.createUserWithEmailAndPassword(
                                      email: email1.text.trim(),
                                      password: pwd1.text.trim());
                                }on FirebaseAuthException catch(e){
                                  error(e.message.toString(), context);
                                }
                              }
                              else if(name.text.isEmpty){
                                error("Enter User Name", context);
                              }
                              else{
                                error("User name must be atleast 6 charecters", context);
                              }
                            },
                            child: Icon(Icons.arrow_forward)
                        ),
                        SizedBox(width: 40,)
                      ],
                    ),
                    SizedBox(height: 40,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an Account?",style: GoogleFonts.bubblegumSans(fontSize: 25,color: Colors.black)),
                        TextButton(
                            onPressed:widget.chSignin,
                            child: Text("Signin",style: GoogleFonts.bubblegumSans(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.black,decoration: TextDecoration.underline),)
                        )
                      ],
                    ),
                    SizedBox(height: 50,),
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
  String user(){
    return name.text.toString();
  }
}
