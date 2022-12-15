import 'dart:math';
import 'package:aves/additional/about_us.dart';
import 'package:aves/additional/how_to_use.dart';
import 'package:aves/widgets/custom_color.dart';
import 'package:aves/widgets/error_message.dart';
import 'package:aves/widgets/popUpDialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:firebase_auth/firebase_auth.dart';
class settings_page extends StatefulWidget {
  settings_page({Key? key,name}) : super(key: key);
  @override
  State<settings_page> createState() => _settings_pageState();
}

class _settings_pageState extends State<settings_page> with SingleTickerProviderStateMixin {
  late AnimationController animcon1;
  bool logo=true;
  var axisalign=MainAxisAlignment.end;
  String mailid="";

  TextEditingController name=TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      mailid=FirebaseAuth.instance.currentUser!.email!;
    });

    animcon1=AnimationController(vsync: this,duration: Duration(seconds: 3));
    animate();
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
            image: DecorationImage(image: AssetImage('assets/sky1.jpg'),fit:BoxFit.cover,opacity: 0.65)
        ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if(logo)SizedBox(height: 40,),
              if(logo)Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.person,color: Colors.cyan,size: 36),
                    SizedBox(width: 10,),
                    colorText(font: 40, text:"Account settings",colors: [Colors.cyan,Colors.cyan,Colors.blueAccent,]),
                  ],
                ),
              if(logo)Container(
                padding: EdgeInsets.all(10),
                child: Container(
                    padding: EdgeInsets.all(10),
                    decoration:BoxDecoration(borderRadius: BorderRadius.circular(20),border: Border.all(color: Colors.cyan,width: 3)),
                    child:Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width:10 ,),
                            Icon(Icons.login_sharp,size: 26,color: Colors.cyan),
                            SizedBox(width: 30,),
                            GestureDetector(
                              onTap: ()=>showDialog(
                                  context: context,
                                  builder: (context)=>customDialog("confirm",()async{
                                    error("Signing Out", context);
                                    await FirebaseAuth.instance.signOut();
                                    Navigator.pop(context);
                                  })
                              ),
                              child:colorText(font: 30, text:"Sign out", colors:[Colors.cyan,Colors.cyan,Colors.blueAccent,]),
                            ),
                          ],
                        ),
                        SizedBox(height: 18,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width:10 ,),
                            Icon(Icons.person,size: 26,color: Colors.cyan),
                            SizedBox(width: 30,),
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) =>
                                        Dialog(
                                            shape: StadiumBorder(),
                                            child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius
                                                      .circular(20),
                                                  image: DecorationImage(
                                                      image: AssetImage(
                                                          'assets/sky1.jpg'),
                                                      fit: BoxFit.cover),),
                                                height: 200,
                                                width: 187,
                                                child: Column(
                                                  children: [
                                                    colorText(
                                                        font: 30,
                                                        text:"Are you sure ??",
                                                        colors: [
                                                          Colors.cyanAccent,
                                                          Colors.cyanAccent,
                                                        ]
                                                    ),
                                                    SizedBox(height: 20,),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                          color: Colors.white38,
                                                          borderRadius: BorderRadius.all(Radius.circular(10))
                                                      ),
                                                      width: 250,
                                                      height: 50,
                                                      child: TextField(
                                                        controller: name,
                                                        textInputAction: TextInputAction.done,
                                                        decoration: InputDecoration(
                                                          contentPadding: EdgeInsets.all(5),
                                                          border:InputBorder.none,
                                                          prefixIcon: Icon(Icons.person),
                                                          hoverColor: Colors
                                                              .black,
                                                          label: Text(
                                                              "New User Name"),
                                                        ),

                                                      ),
                                                    ),
                                                    SizedBox(height: 40,),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        TextButton(onPressed:(){
                                                          if(name.text.length>=6){
                                                            FirebaseFirestore.instance.collection("UserData").doc(mailid).set({"name":name.text.toString()});
                                                            name=TextEditingController(text: "");
                                                            Navigator.pop(context);
                                                          }
                                                          else{
                                                            error("User name should have atleast 6 characters ", context);
                                                          }
                                                        },
                                                            child:colorText(font:30, text:"confirm", colors: [Colors.cyan, Colors.cyanAccent,],)
                                                        ),
                                                        SizedBox(width: 30,),
                                                        TextButton(
                                                            onPressed: (){
                                                              name=TextEditingController(text: "");
                                                              Navigator.pop(context);
                                                              FocusManager.instance.primaryFocus?.unfocus();
                                                            },
                                                            child:colorText(
                                                              font:30,
                                                              text: "back",
                                                              colors: [Colors.cyan,Colors.cyanAccent,],
                                                            )
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                )
                                            )
                                        )
                                );
                              },
                              child:colorText(font: 30, text:"Change User Name", colors:[Colors.cyan,Colors.cyan,Colors.blueAccent,]),
                            ),
                          ],
                        ),

                        SizedBox(height: 18,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width:10 ,),
                            Icon(Icons.lock_reset,size: 26,color: Colors.cyan),
                            SizedBox(width: 30,),
                            GestureDetector(

                              onTap: ()=>showDialog(
                                  context: context,
                                  builder: (context)=>customDialog("Confirm",()async{
                                    try{
                                      await FirebaseAuth.instance.sendPasswordResetEmail(email:mailid);
                                    } on FirebaseAuthException catch(e){
                                            error(e.message.toString(), context);
                                    }
                                    error('Reset Password link is sent to Resgistered Mail ID', context);
                                    Navigator.pop(context);
                                  })
                              ),
                              child:colorText(font: 30, text:"Reset Password", colors:[Colors.cyan,Colors.cyan,Colors.blueAccent,]),
                            ),
                          ],
                        ),

                      ],
                    )
                ),
              ),
              if(logo)SizedBox(height: 30,),
              if(logo)Row(

                  children: [
                    SizedBox(width: 60,),
                    Icon(Icons.settings_suggest_sharp,color: Colors.cyan,size: 36),
                    SizedBox(width: 10,),
                    colorText(font: 40, text:"General",colors: [Colors.cyan,Colors.cyan,Colors.blueAccent,]),
                  ],
              ),
              if(logo)Container(
                padding: EdgeInsets.all(10),
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration:BoxDecoration(borderRadius: BorderRadius.circular(20),border: Border.all(color: Colors.cyan,width: 3)),
                  child:Column(
                      children:[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width:10 ,),
                            Icon(Icons.question_mark,size: 26,color: Colors.cyan),
                            SizedBox(width: 30,),
                            GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder:(context) => instructons(),));
                              },
                              child:colorText(font: 30, text:"How to use", colors:[Colors.cyan,Colors.cyan,Colors.blueAccent,]),
                            ),
                          ],

                        ),

                        SizedBox(height: 18,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width:10 ,),
                            Icon(Icons.info,size: 26,color: Colors.cyan),
                            SizedBox(width: 30,),
                            GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder:(context) => AboutUs(),));
                              },
                              child:colorText(font: 30, text:"About us", colors:[Colors.cyan,Colors.cyan,Colors.blueAccent,]),
                            ),
                          ],
                        ),
                        SizedBox(height: 18,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width:10 ,),
                            Icon(Icons.history,size: 26,color: Colors.cyan),
                            SizedBox(width: 30,),
                            GestureDetector(
                              onTap: (){
                                showModalBottomSheet(
                                  elevation: 0,
                                    backgroundColor: Colors.transparent,
                                    context: context,
                                    builder: (context) => Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: MediaQuery.of(context).size.height,
                                      decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/sky1.jpg"),fit: BoxFit.cover)),
                                      child:SingleChildScrollView(
                                      child:Column(
                                        children: [
                                          StreamBuilder<QuerySnapshot>(
                                            stream: FirebaseFirestore.instance.collection(mailid).snapshots(),
                                            builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
                                              if(snapshot.connectionState == ConnectionState.waiting){
                                                return const Center(child: CircularProgressIndicator(),
                                                );
                                              }
                                              if(snapshot.hasData){
                                                return ListView.builder(
                                                  physics: NeverScrollableScrollPhysics(),
                                                  shrinkWrap: true,
                                                  itemCount: snapshot.data!.docs.length,
                                                  itemBuilder: (context, index) {
                                                    var data=snapshot.data!.docs[index].data() as Map<String,dynamic>;
                                                      return Prediction(data);
                                                  },
                                                );
                                              }
                                              return colorText(font: 17, text:"History is empty", colors:[Colors.blueAccent, Colors.lightBlue,]);
                                            },
                                          ),

                                        ],
                                      ),
                                    ),
                                    ),
                                );
                              },
                              child:colorText(font: 30, text:"History", colors:[Colors.cyan,Colors.cyan,Colors.blueAccent,]),
                            ),
                          ],
                        ),
                      ]
                  ),

                ),
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
                    height: 200,
                    width: 200,
                    repeat: false,
                    controller: animcon1,

                  ),
                  if(pos[1]||pos[5])SizedBox(width: 50,),
                  if(pos[3]||pos[7])SizedBox(width: 12,),
                ],
              )
            ],
          ),
      ),

      floatingActionButton: FloatingActionButton(
        child: CircleAvatar(
          radius: 50,
          backgroundImage: AssetImage('assets/icon.png'),
        ),
        onPressed: (){
          setState(() {
            animcon1.reset();
            pos[index]=false;
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

        },
      ),

    );
  }

}

Widget Prediction(Map<String,dynamic> doct) {
  return GestureDetector(
      child:Column(
        children:[
          SizedBox(height: 13,),
          Container(
            width: 369,
              decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10.0)),
              child:
              ListTile(
                selected: true,
                title: colorText(
                  text:doct['prediction'],
                  font: 18,
                  colors:[Colors.blueAccent, Colors.lightBlue,],
                ),
                subtitle: colorText(
                  text:doct['confidence'],
                  font: 14,
                  colors: [Colors.blueAccent, Colors.lightBlue,],
                ),
                // decoration: UnderlineTabIndicator( insets: EdgeInsets.all(2.0)),
                leading:Container(
                  width: 90,
                  height: 90,
                  child:Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(doct['image url']),

                      ),
                    ],
                  ),
                ),

                trailing:IconButton(
                  icon:Icon(Icons.delete,size: 30,color: Colors.cyan,),
                      onPressed:(){
                          String mailid=FirebaseAuth.instance.currentUser!.email!;
                        FirebaseStorage.instance.refFromURL(doct['image url']).delete();
                      FirebaseFirestore.instance.collection(mailid).doc(doct['docid']).delete();
                      } ,
                ),
                ),
              )
        ],
      ),
  );

}

