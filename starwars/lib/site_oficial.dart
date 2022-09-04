import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class SiteOficial extends StatefulWidget {
  const SiteOficial({super.key});

  @override
  State<SiteOficial> createState() => _SiteOficialState();
}

class _SiteOficialState extends State<SiteOficial> {
  double _progress = 0;
  late InAppWebViewController webView;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height-150,
      child: Scaffold(
        key: scaffoldKey,
        body: Stack(
          children: [
            InAppWebView(
              initialUrlRequest: URLRequest(
                url: Uri.parse("https://www.starwars.com/community")
              ),
              onWebViewCreated: (InAppWebViewController controller){
                webView = controller;
              },
              onProgressChanged: (InAppWebViewController controller, int progress){
                setState(() {
                  _progress = progress / 100;
                });
              },
            ),
            _progress < 1 ? SizedBox(
              height: 3,
              child: LinearProgressIndicator(
                value: _progress,
              ),
            ) : const SizedBox()
          ],
        )
      ),
    );
  }
}