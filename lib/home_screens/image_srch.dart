import 'dart:io';
import 'dart:math';
import 'package:aves/additional/birds_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';
import 'package:image/image.dart' as img;
import 'package:aves/widgets/custom_color.dart';
import 'package:aves/widgets/error_message.dart';
import 'package:aves/widgets/web_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../predict/predict_class.dart';
class search_img_page extends StatefulWidget {
  search_img_page({Key? key,name}) : super(key: key);
  @override
  State<search_img_page> createState() => _search_img_pageState();
}

class _search_img_pageState extends State<search_img_page> with TickerProviderStateMixin{
  late AnimationController animcon1;
  late AnimationController _controller;
  TextEditingController link=TextEditingController();
  late Classifier _classifier;
  Category? category;
  bool logo = true;
  bool image = true;
  String path = "";
  String mail="";
  String name="";
  bool predict=false;
  var axisalign = MainAxisAlignment.end;

  bool upload=false;
  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      mail=FirebaseAuth.instance.currentUser!.email!;
    });
    _classifier = Classifier();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds:1200));
    animcon1 = AnimationController(vsync: this, duration: Duration(seconds: 3));
    animate();
    super.initState();
  }

  void animate() {
    animcon1.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animcon1.reset();
        setState(() {
          logo = true;
          pos[index] = false;
        });
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    animcon1.dispose();
    _controller.dispose();
    super.dispose();
  }

  List<bool> pos = [false, false, false, false, false, false, false, false];
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/sky1.jpg'),
                fit: BoxFit.cover)
        ),
        child: Center(
          child: Column(
            children: [
              if(logo)SizedBox(height: 30,),
              if(image&&logo)Container(
                width: 350,
                height: 270,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: AssetImage("assets/empty.jpg"),
                        fit: BoxFit.cover
                    )
                ),
              ),
              if(!image&&logo)Container(
                width: 350,
                height: 270,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: FileImage(File(path)),
                        fit: BoxFit.fill
                    )
                ),
              ),
              if(logo)SizedBox(height: 25,),
              if(logo)Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FloatingActionButton.extended(
                    onPressed: () {
                      if(!image){
                        File _image=File(path);
                        img.Image imageInput = img.decodeImage(_image.readAsBytesSync())!;
                        var pred = _classifier.predict(imageInput);
                        setState(() {
                          this.category = pred;
                          predict=true;
                        });
                      }
                      else{
                        error('Select Image', context);
                      }
                      Future.delayed(Duration(microseconds:300),() =>_controller.forward(from: 0.0),);
                    },
                    label: Text('Predict', style: GoogleFonts.bubblegumSans(
                        fontSize: 25),),
                    backgroundColor: Colors.blueAccent,
                  ),
                  image?SizedBox(width: 70,):SizedBox(width: 130,),
                  image?FloatingActionButton.extended(

                    onPressed: () async {
                      setState(() {
                        upload=true;
                      });
                        final pickfile = await ImagePicker().pickImage(source: ImageSource.gallery);
                        if (pickfile == null) {
                          return;
                        }
                        else {
                          final croppedFile = await ImageCropper().cropImage(
                            sourcePath: pickfile.path,
                            compressFormat: ImageCompressFormat.jpg,
                            aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
                            uiSettings: [
                              AndroidUiSettings(
                                  toolbarTitle: 'Cropper',
                                  toolbarColor: Colors.deepOrange,
                                  toolbarWidgetColor: Colors.white,
                                  initAspectRatio: CropAspectRatioPreset.original,
                                  lockAspectRatio: false),
                              IOSUiSettings(
                                title: 'Cropper',
                              ),
                            ],
                          );
                          if (croppedFile != null) {
                            setState(() {
                              path= croppedFile.path;
                              predict=false;
                              image=false;
                              name=pickfile.name;
                            });
                          }
                          else{
                            setState(() {
                              predict=false;
                              image=false;
                              path = pickfile.path;
                              name=pickfile.name;
                            });
                          }
                        }
                    },
                    label: Text('Select Image', style: GoogleFonts
                        .bubblegumSans(fontSize: 25),),
                    backgroundColor: Colors.blueAccent,
                  ):FloatingActionButton.extended(
                    onPressed: () async {
                      if(upload&&predict){
                        try{
                          await FirebaseStorage.instance.ref('$mail/$name').putFile(File(path));
                        }on FirebaseException catch (e){print(e);}
                        String dt=await FirebaseStorage.instance.ref('$mail/$name').getDownloadURL();
                        String date=DateTime.now().toString();
                        FirebaseFirestore.instance.collection(mail).doc(date).set({
                          "prediction":category!.label,
                          "confidence":"${(category!.score*100).toStringAsFixed(2)}%",
                          "image url":dt,
                          "docid":date,
                        }).catchError((error) => print("Failed to add new profile due to $error"));
                      }
                      setState(() {
                          image=true;
                          predict=false;
                        upload=false;
                      });
                    },
                    label: Text('Clear', style: GoogleFonts
                        .bubblegumSans(fontSize: 25),),
                    backgroundColor: Colors.blueAccent,
                  ),
                ],
              ),
              SizedBox(height: 30,),
              if(predict&&logo)
              SlideTransition(
                position:Tween<Offset>(
                  end: Offset.zero,
                  begin: const Offset(-2, 0.0),
                ).animate(CurvedAnimation(
                  parent: _controller,
                  curve: Curves.elasticIn,
                )),
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      category != null ? category!.label: '',
                      style: GoogleFonts.bubblegumSans(fontSize: 25,color: Colors.black87,),
                    )
                  ],
                ),
              ),
              if(predict&&logo)
              SlideTransition(
                position:Tween<Offset>(
                  end: Offset.zero,
                  begin: const Offset(2, 0.0),
                ).animate(CurvedAnimation(
                  parent: _controller,
                  curve: Curves.elasticIn,
                )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      // "confidence",
                      "Confidence : ${(category!.score*100).toStringAsFixed(2)}%",
                      style: GoogleFonts.bubblegumSans(fontSize: 25,color: Colors.black87,),)
                  ],
                ),
              ),
              if(predict&&logo)
                SlideTransition(
                position:Tween<Offset>(
                  end: Offset.zero,
                  begin: const Offset(0.0,5),
                ).animate(CurvedAnimation(
                  parent: _controller,
                  curve: Curves.elasticIn,
                )),
                child:ListTile(
                  leading: SizedBox(width: 75,),
                  title: Row(
                    children: [
                      colorText(font: 30, text:"More Details", colors:[Colors.cyan,Colors.cyan,Colors.blueAccent,]),
                      SizedBox(width: 10,),
                      Icon(Icons.arrow_forward_ios_sharp),
                    ],
                  ),
                  onTap: (){
                    String name=category!.label.toString();
                    String? link=info.weblink[name];
                    print(link);
                    Navigator.push(context,MaterialPageRoute(builder: (context)=>wikiPedia(link!)));

                  },
                ),
              ),
              if(pos[0])SizedBox(height: 70,),
              if(pos[1])SizedBox(height: 120,),
              if(pos[2])SizedBox(height: 170,),
              if(pos[3])SizedBox(height: 200,),
              if(pos[4])SizedBox(height: 250,),
              if(pos[5])SizedBox(height: 320,),
              if(pos[6])SizedBox(height: 370,),
              if(pos[7])SizedBox(height: 400,),
              if(!logo)Row(
                mainAxisAlignment: axisalign,
                children: [
                  if(pos[0] || pos[4])SizedBox(width: 10,),
                  if(pos[2] || pos[6])SizedBox(width: 75,),
                  Lottie.asset(
                    'assets/bird.json',
                    height: 200,
                    width: 200,
                    repeat: false,
                    controller: animcon1,

                  ),
                  if(pos[1] || pos[5])SizedBox(width: 50,),
                  if(pos[3] || pos[7])SizedBox(width: 12,),
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
        onPressed: () {
          // int index=1;
          setState(() {
            pos[index]=false;
            index = Random().nextInt(8);
            logo = false;
            pos[index] = true;
            animcon1.forward();
          });
          if (index == 0 || index == 4 || index == 2 || index == 6) {
            setState(() {
              axisalign = MainAxisAlignment.start;
            });
          }
          else {
            setState(() {
              axisalign = MainAxisAlignment.end;
            });
          }
        },
      ),

    );
  }


}
