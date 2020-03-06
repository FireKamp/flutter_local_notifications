import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sudoku_brain/components/gradient_line.dart';
import 'package:sudoku_brain/components/header_text.dart';
import 'package:sudoku_brain/components/top_container.dart';
import 'package:sudoku_brain/utils/Constants.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:xlive_switch/xlive_switch.dart';

class TermsOfUse extends StatelessWidget {
  final double spaceBTText = 15.0;
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

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
            color: kPrimaryColor,
            height: MediaQuery.of(context).size.height * 0.60,
            child: WebView(
              initialUrl: 'https://www.matchalagames.com/terms-of-service/',
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                _controller.complete(webViewController);
              },
              // TODO(iskakaushik): Remove this when collection literals makes it to stable.
              // ignore: prefer_collection_literals
              navigationDelegate: (NavigationRequest request) {
                if (request.url.startsWith('https://www.youtube.com/')) {
                  print('blocking navigation to $request}');
                  return NavigationDecision.prevent;
                }
                print('allowing navigation to $request');
                return NavigationDecision.navigate;
              },
              onPageStarted: (String url) {
                print('Page started loading: $url');
              },
              onPageFinished: (String url) {
                print('Page finished loading: $url');
              },
              gestureNavigationEnabled: true,
            ),
          )
        ],
      ),
    );
  }
}

class SettingsItem extends StatelessWidget {
  const SettingsItem({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        SmallText(
          text: 'Turn On Sounds',
        ),
        XlivSwitch(
          unActiveColor: Color(0xFFD0D0D0),
          activeColor: Color(0xFF0AB8AD),
          value: false,
          onChanged: (bool val) {},
        ),
      ],
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
