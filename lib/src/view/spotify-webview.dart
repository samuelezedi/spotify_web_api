import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
                  color: Colors.black,
                  height: 110,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Are you sure you want to close this?',),
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
      onWillPop: () {
        Navigator.pop(context);
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
              ),
              onPressed: () {
                //working on here
                showAdvice();
              },
            ),
          ),
          body: Builder(builder: (context) {
            mContext = context;
            return Stack(
              children: <Widget>[
                WebView(
                  initialUrl:
                  "${widget.url}",
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: (WebViewController con) {
                    controller = con;
                  },
                  onPageStarted: (c) {
                    controller.currentUrl().then((_) {
                      print(_);
                    });
                  },

                  onPageFinished: (c) {
                    if (c == widget.redirectUrl) {
                      String code = this.getCodeParameter(widget.redirectUrl);
                      Navigator.pop(context, code);
                    } else if (c == widget.url) {
                      setState(() {
                        showLoading = !showLoading;
                      });
                    }
                  },

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