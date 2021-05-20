import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:webview_flutter/webview_flutter.dart';




class SpotifyWebView extends StatefulWidget {
  String url;
  String redirectUrl;

  SpotifyWebView({this.url,this.redirectUrl});

  @override
  _SpotifyWebViewState createState() => _SpotifyWebViewState();
}

class _SpotifyWebViewState extends State<SpotifyWebView> {

  bool showLoading = true;

  BuildContext mContext;

  WebViewController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  // InAppWebViewController webViewController;
  // InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
  //     crossPlatform: InAppWebViewOptions(
  //       useShouldOverrideUrlLoading: true,
  //       mediaPlaybackRequiresUserGesture: false,
  //     ),
  //     android: AndroidInAppWebViewOptions(
  //       useHybridComposition: true,
  //     ),
  //     ios: IOSInAppWebViewOptions(
  //       allowsInlineMediaPlayback: true,
  //     ));

  showAdvice() {
    showDialog(
        context: context,
        builder: (_) =>
            AlertDialog(
              backgroundColor: Colors.white,
              contentPadding: EdgeInsets.all(15),
              shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
              content: Container(
                  color: Colors.white,
                  height: 110,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Are you sure you want to close this?',style: TextStyle(color: Colors.black),),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                'NO',
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                'YES',
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  )),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        //bool cgb = await controller.canGoBack();
        if(controller!=null && (await controller.canGoBack())){
          controller.goBack();
        }else{
          showAdvice();
        }
        return Future.value(false);
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () async{
                //working on here
                if(await controller.canGoBack()) {
                  controller.goBack();
                  return;
                }
                showAdvice();
              },
            ),
          ),
          body: Builder(builder: (context) {
            mContext = context;
            return Stack(
              children: <Widget>[
                // InAppWebView(
                //   initialUrlRequest:URLRequest(url: Uri.parse("${widget.url}")),
                //   initialOptions: options,
                //   onWebViewCreated: (con) {
                //     controller = con;
                //   },
                //   onLoadStart: (c,url) {
                //     // controller.currentUrl().then((_) {
                //     //   print(_);
                //     // });
                //   },
                //
                //   onLoadStop: (c,url) {
                //     setState(() {
                //       showLoading = false;
                //     });
                //     if (url.toString().contains("code=")) {
                //       Future.delayed(Duration(seconds: 2));
                //       String code = this.getCodeParameter(url.toString());
                //       Navigator.pop(context, code);
                //     }
                //   },
                //
                // ),
                WebView(
                  gestureRecognizers: Set()
                    ..add(Factory<VerticalDragGestureRecognizer>(
                            () => VerticalDragGestureRecognizer())),
                  initialUrl:
                  "${widget.url}",
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: (WebViewController con) {
                    setState(() {
                      controller = con;
                    });
                  },
                  onPageStarted: (c) {
                    controller.currentUrl().then((_) {
                      print(_);
                    });
                  },

                    onProgress: (p){
                    print(p);
                      if(p>70 && showLoading){
                        setState(() {
                          showLoading = false;
                        });
                      }
                    },

                  onPageFinished: (c) {
                    setState(() {
                      showLoading = false;
                    });
                    if (c.contains("code=")) {
                      Future.delayed(Duration(seconds: 2));
                      String code = this.getCodeParameter(c);
                      Navigator.pop(context, code);
                    }
                  }


                ),
                showLoading ? Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                ) : Offstage(),
              ],
            );
          })),
    );
  }

  String getCodeParameter(String url) {
    return Uri.dataFromString(url).queryParameters['code']; // http://localhost:8082/game.html?id=15&randomNumber=3.14
  }
}