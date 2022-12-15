import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';
class wikiPedia extends StatefulWidget {
  final String link;
  const wikiPedia(this.link,{Key? key}) : super(key: key);

  @override
  State<wikiPedia> createState() => _wikiPediaState();
}

class _wikiPediaState extends State<wikiPedia> {
  String initial_link="";
  @override
  void initState() {
      setState(() {
        initial_link=widget.link;
      });
    super.initState();

  }
  int bar=0;
  late WebViewController _controller;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // appBar: AppBar(),
      body: Stack(
        children: [
          WebView(
            backgroundColor: Colors.cyan,
            zoomEnabled: true,
            initialUrl: initial_link,
            javascriptMode: JavascriptMode.unrestricted,
            onProgress: (int progress) {
              print('WebView is loading (progress : $progress%)');
              setState(() {
                bar=progress;
              });
            },
            onWebViewCreated: (webViewController) {
              _controller=webViewController;
            },
            onPageStarted: (String url){
              Future.delayed(Duration(milliseconds: 500),(){
                _controller.runJavascript("document.getElementsByTagName('header')[0].style.display='none'");
                _controller.runJavascript("document.getElementsByTagName('footer')[0].style.display='none'");
              });

            },
            navigationDelegate: (NavigationRequest request) {
              if (request.url.startsWith(initial_link)) {
                print('blocking navigation to $request}');
                return NavigationDecision.navigate;
              }
              print('allowing navigation to $request');
              return NavigationDecision.prevent;
            },
          ),
          if(bar<100)Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(gradient: SweepGradient(center: Alignment.center,colors: [Colors.blueAccent,Colors.redAccent,Colors.amber,Colors.pink,Colors.indigoAccent])),
          ),
          if(bar<100)Center(
            child:Container(
              width: 130,
              height: 200,
              child: Column(
                children: [
                  Row(
                    children: [
                      Text("Loading $bar%",style: GoogleFonts.bubblegumSans(fontSize: 25,color: Colors.black87,),),
                    ],
                  ),
                  SizedBox(height: 20,),
                  LinearProgressIndicator(minHeight: 8,value: bar/100,color: Colors.black87,)
                ],
              ),
            ),
          )
        ],
      )
    );
  }
}
