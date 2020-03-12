import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sudoku_brain/components/gradient_line.dart';
import 'package:sudoku_brain/components/header_text.dart';
import 'package:sudoku_brain/components/top_container.dart';
import 'package:sudoku_brain/utils/Constants.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TermsOfUse extends StatefulWidget {
  @override
  _TermsOfUseState createState() => _TermsOfUseState();
}

class _TermsOfUseState extends State<TermsOfUse> {
  final double spaceBTText = 15.0;

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  bool _isLoaded = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          TopContainer(
            onPressed: () {
              Navigator.pop(context);
            },
            text: 'TERMS OF USE',
            imagePath: 'assets/images/ic_tou.png',
            gradient: LinearGradient(
              colors: <Color>[Color(0xFF1E9FFE), Color(0xFF125B91)],
            ),
            circleGradient: LinearGradient(
              colors: <Color>[Color(0xFF8EC4EC), Color(0xFF198CE1)],
            ),
            color: Color(0xFF8EC4EC),
          ),
          Visibility(
            visible: false,
            child: Container(
              padding: EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 0.0),
              width: MediaQuery.of(context).size.width,
              color: kPrimaryColor,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: spaceBTText,
                    ),
                    HeaderText(
                      text: 'TERMS OF USE',
                    ),
                    GradientLine(
                      gradient: LinearGradient(
                        colors: <Color>[Color(0xFF8DFDC4), Color(0xFF32C6A2)],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: double.maxFinite,
            color: kPrimaryColor,
            height: MediaQuery.of(context).size.height * 0.60,
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: WebView(
                    initialUrl:
                        'https://www.matchalagames.com/terms-of-service/',
                    javascriptMode: JavascriptMode.unrestricted,
                    onWebViewCreated: (WebViewController webViewController) {
                      _controller.complete(webViewController);
                    },
                    navigationDelegate: (NavigationRequest request) {
                      print('allowing navigation to $request');
                      return NavigationDecision.navigate;
                    },
                    onPageStarted: (String url) {
                      print('Page started loading: $url');
                    },
                    onPageFinished: (String url) {
                      print('Page finished loading: $url');
                      setState(() {
                        _isLoaded = true;
                      });
                    },
                    gestureNavigationEnabled: true,
                  ),
                ),
                Positioned(
                  child: Visibility(
                    visible: _isLoaded == false ? true : false,
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor:
                            new AlwaysStoppedAnimation<Color>(kPrimaryColor),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class SmallText extends StatelessWidget {
  final String text;

  SmallText({this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.left,
      style: TextStyle(
          fontFamily: 'Rubik',
          fontSize: 14.0,
          color: Colors.white,
          fontWeight: FontWeight.w200,
          decoration: TextDecoration.none),
    );
  }
}
