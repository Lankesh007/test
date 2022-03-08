import 'package:asb_news/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewContactUsScreen extends StatefulWidget {
  const WebViewContactUsScreen({Key? key}) : super(key: key);

  @override
  State<WebViewContactUsScreen> createState() => _WebViewContactUsScreenState();
}

class _WebViewContactUsScreenState extends State<WebViewContactUsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeColor,
        title: const Text(
          'Contact Us',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: const WebView(
        initialUrl: 'https://www.asbnewsindia.com/contact-us/',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
