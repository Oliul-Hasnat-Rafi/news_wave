import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleView extends StatefulWidget {
  String blogUrl;

  ArticleView({required this.blogUrl});

  @override
  State<ArticleView> createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
  bool isLoading = true;
  final _key = UniqueKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'NEWS',
              style: TextStyle(fontSize: 20, color: Colors.blue),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              'WAVE',
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          WebView(
            key: _key,
            initialUrl: widget.blogUrl,
            javascriptMode: JavascriptMode.unrestricted,
            onPageStarted: (Start) {
              setState(() {
                isLoading = false;
              });
            },
          ),
          isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Stack(),
        ],
      ),
    );
  }
}
