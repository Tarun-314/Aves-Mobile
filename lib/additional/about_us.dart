import 'package:aves/widgets/custom_color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  String abt='''
Ever wondered what kind of bird you just saw? Aves is the app for you.

Birds, you know them. They're like the second thing that most people learn about in science class, right after the Earth's environment and how it's threatened. But what if you're out exploring nature and come across a bird, but don't know what it is? Well, you could go home and find out on Wikipedia or something, or you could use Aves. 

This app offers a new way of exploring the bird world. It can take a picture of any bird, and in case it's in the data set of 450 birds, it will help you find its name.

We are a developers of the app that helps people with learning about new birds. We can tell you the name and its details of the bird if we have its picture.

''';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage('assets/sky1.jpg'),fit:BoxFit.cover)
          ),
          child: Column(
            children: [
              SizedBox(height:7 ,),
              ShaderMask(
                shaderCallback: (rect)=>LinearGradient(
                    colors: [
                      Colors.lightBlue,
                      Colors.cyanAccent,
                    ]
                ).createShader(rect),
                child: Text("AVES",style:GoogleFonts.bubblegumSans(fontSize: 70,color:Colors.white,) ),
              ),
              SizedBox(height: 40,),
              Text(abt,style: GoogleFonts.bubblegumSans(fontSize: 25,color: Colors.black87,),),
              colorText(font: 20, text:"Developed by Tarun Kumar Talloju", colors:[Colors.cyan,Colors.cyan,Colors.blueAccent,]),
              SizedBox(height: 20,),

              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/icon.png'),
                  ),
                ],
              ),
            ],
          ),
        )
      ),
    );
  }
}
