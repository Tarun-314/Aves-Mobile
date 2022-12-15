import 'package:flutter/material.dart';

import 'custom_color.dart';
class customDialog extends StatefulWidget {
  final Function()? ontap;
  final String left;
  customDialog(this.left,this.ontap,{Key? key}) : super(key: key);

  @override
  State<customDialog> createState() => _customDialogState();
}

class _customDialogState extends State<customDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: StadiumBorder(),
        child:Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),image: DecorationImage(image: AssetImage('assets/sky1.jpg'),fit: BoxFit.cover),),
          height: 200,
          width: 187,
          child: Column(
            children: [
              SizedBox(height: 50,),
              colorText(
                  font: 40,
                  text:"Are you sure ??",
                  colors: [
                    Colors.cyanAccent,
                    Colors.cyanAccent,
                  ]
              ),
              SizedBox(height:50 ,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(onPressed:widget.ontap,
                      child:colorText(
                        font:30,
                        text:widget.left,
                        colors: [
                          Colors.cyan,
                          Colors.cyanAccent,
                        ],
                      )
                  ),
                  SizedBox(width: 30,),
                  TextButton(
                      onPressed: (){
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
          ),
        )
    );
  }
}
