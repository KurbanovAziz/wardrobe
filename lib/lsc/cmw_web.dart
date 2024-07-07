import 'package:closet_my_wardrobe_40_a/lsc/cmw_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CMWWeb extends StatefulWidget {
  final String url;
  final String title;

  const CMWWeb({
    super.key,
    required this.title,
    required this.url,
  });

  @override
  State<CMWWeb> createState() => _RunWebPageState();
}

class _RunWebPageState extends State<CMWWeb> {
  late WebViewController controller;
  @override
  void initState() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.url));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: CMWColor.white,
        title: Text(
          widget.title,
          style: TextStyle(
            fontSize: 20.h,
            color: CMWColor.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: const BackButton(
          color: CMWColor.black,
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Expanded(
              child: WebViewWidget(
                controller: controller,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
