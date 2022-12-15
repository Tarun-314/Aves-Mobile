import 'package:aves/widgets/custom_color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class instructons extends StatefulWidget {
  const instructons({Key? key}) : super(key: key);

  @override
  State<instructons> createState() => _instructonsState();
}

class _instructonsState extends State<instructons> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                image: DecorationImage(opacity: 0.65,image: AssetImage('assets/sky1.jpg'),fit:BoxFit.cover)
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
                colorText(font: 30, text:"Search by Name", colors:[Colors.cyan,Colors.cyan,Colors.blueAccent,]),
                SizedBox(height: 13,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    FloatingActionButton(onPressed: (){},child:Icon(Icons.search,size: 40,)),
                  ],
                ),
                SizedBox(height: 8,),
                Text(
                  "Tap on This Icon to search a bird by it's name. Then you will see a page with names and a search box at the top of the page, type the name in the box and you will see the list birds matching that name",
                  style: GoogleFonts.bubblegumSans(fontSize: 25,color: Colors.black87,),
                ),
                SizedBox(height: 20,),
                colorText(font: 30, text:"Search by Image", colors:[Colors.cyan,Colors.cyan,Colors.blueAccent,]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    FloatingActionButton(onPressed: (){},child:Icon(Icons.image_search,size: 40,),),
                  ],
                ),
                SizedBox(height: 8,),
                Text('Tap on This icon to search a bird by Image',style: GoogleFonts.bubblegumSans(fontSize: 25,color: Colors.black87,),),
                SizedBox(height: 13,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    FloatingActionButton.extended(
                      onPressed: () {},
                      label: Text('Select Image', style: GoogleFonts
                          .bubblegumSans(fontSize: 20),),
                      backgroundColor: Colors.blueAccent,
                    ),
                    SizedBox(width: 20,),
                  ],
                ),
                SizedBox(height: 8,),
                Text('Then press this button to select the image ',style: GoogleFonts.bubblegumSans(fontSize: 25,color: Colors.black87,),),
                SizedBox(height: 13,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    FloatingActionButton.extended(
                      onPressed: () {},
                      label: Text('Predict', style: GoogleFonts
                          .bubblegumSans(fontSize: 20),),
                      backgroundColor: Colors.blueAccent,
                    ),
                    SizedBox(width: 20,),
                  ],
                ),
                SizedBox(height: 8,),
                Text('After selecting Image press this button to get the name of the bird in the image ',style: GoogleFonts.bubblegumSans(fontSize: 25,color: Colors.black87,),),
                SizedBox(height: 13,),
                Text("If you want more details about the bird click on more details",style: GoogleFonts.bubblegumSans(fontSize: 25,color: Colors.blueGrey,),),
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
