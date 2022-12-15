import 'dart:async';
import 'dart:math';
import 'package:aves/additional/birds_info.dart';
import 'package:aves/widgets/custom_color.dart';
import 'package:aves/widgets/web_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
class search_page extends StatefulWidget {
  search_page({Key? key,name}) : super(key: key);
  @override
  State<search_page> createState() => _search_pageState();
}

class _search_pageState extends State<search_page> with SingleTickerProviderStateMixin {
  late AnimationController animcon1;
  bool logo=true;
  var axisalign=MainAxisAlignment.end;
  String srch="";

  TextEditingController search=TextEditingController();
  @override
  void initState() {
    // TODO: implement initState

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
  bool load=false;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0,
      //   backgroundColor: Colors.transparent,
      //   actions: [
      //     Icon(Icons.search,size: 40,color: Colors.cyanAccent,),
      //   ],
      //
      // ),
      extendBodyBehindAppBar:true,
      body:Stack(
        fit: StackFit.expand,
        children: [
          Container(
              width: MediaQuery.of(context).size.width,
              height:MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  image: DecorationImage(opacity: 0.65,image: AssetImage('assets/sky1.jpg'),fit:BoxFit.cover)
            ),
          ),

          SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 60,),
                    if(srch.isEmpty)ListView(

                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children:info.birds.map((e) => ListTile(
                        onTap: (){
                          String? link=info.weblink[e];
                          Navigator.push(context,MaterialPageRoute(builder: (context)=>wikiPedia(link!)));
                        },
                        title: colorText(font: 27,
                            text: e,
                            colors: [
                              Colors.cyan,
                              Colors.cyan,
                              Colors.blueAccent,
                            ]),
                        trailing: Icon(Icons.arrow_forward_ios_sharp),
                        tileColor: Colors.transparent,
                      )).toList(),
                    ),
                    if(logo)ListView.builder(
                      shrinkWrap: true,
                      itemCount: info.birds.length,
                      physics:NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index){
                        if(srch.isNotEmpty&&info.birds[index].toString().toLowerCase().startsWith(srch.toLowerCase())) {
                            return ListTile(
                              title: colorText(font: 27,
                                  text: info.birds[index],
                                  colors: [
                                    Colors.cyan,
                                    Colors.cyan,
                                    Colors.blueAccent,
                                  ]),
                              trailing: Icon(Icons.arrow_forward_ios_sharp),
                              tileColor: Colors.transparent,
                              onTap: (){
                                String? link=info.weblink[info.birds[index]];
                                Navigator.push(context,MaterialPageRoute(builder: (context)=>wikiPedia(link!)));
                              },
                            );

                        }
                        return ColoredBox(color: Colors.transparent);
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
                    Row(
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
          Positioned(
            top: 10,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 55,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(40),gradient:LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.white,
                    Colors.lightBlueAccent,

                  ]
              ),
              ),
              child: Container(
                width: 280,
                child: TextField(
                  controller: search,
                  onChanged: (val){
                    setState((){
                      load=true;
                      srch=val;
                    });
                    Future.delayed(Duration(milliseconds: 425), () {
                      setState(() {
                        load=false;
                      });
                    });
                  },

                  style: GoogleFonts.bubblegumSans(fontSize: 28,color: Colors.blue),
                  cursorColor: Colors.black87,
                  decoration:InputDecoration(
                    hoverColor: Colors.cyan,
                    contentPadding: EdgeInsets.all(5),
                    border: InputBorder.none,
                    hintText: "",
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 18,
              right: 18,
              child: Icon(
                  Icons.search,
                  color: Colors.cyan,
                  size: 40,
                ),
          ),
          if(load)Center(
            child:CircularProgressIndicator(strokeWidth: 4),
          )

        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: CircleAvatar(
          radius: 50,
          backgroundImage: AssetImage('assets/icon.png'),
        ),
        onPressed: (){
          // int index=1;
          setState(() {
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


