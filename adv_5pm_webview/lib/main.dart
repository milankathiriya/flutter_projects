import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

void main() {
  runApp(
    const MaterialApp(
      home: HomePage(),
    ),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  InAppWebViewController? _webViewController;

  late PullToRefreshController pullToRefreshController;

  List<String> bookmarks = <String>[];

  double progress = 0;

  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  @override
  void initState() {
    super.initState();
    pullToRefreshController = PullToRefreshController(onRefresh: () async {
      if (Platform.isAndroid) {
        _webViewController!.reload();
      } else if (Platform.isIOS) {
        Uri? currentURL = await _webViewController!.getUrl();
        _webViewController!
            .loadUrl(urlRequest: URLRequest(url: Uri.parse(currentURL!.path)));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("WebView"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.home),
          onPressed: () {
            _webViewController!.loadUrl(
                urlRequest:
                    URLRequest(url: Uri.parse("https://www.google.co.in")));
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () async {
              if (await _webViewController!.canGoBack()) {
                await _webViewController!.goBack();
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () async {
              await _webViewController!.reload();
            },
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios),
            onPressed: () async {
              if (await _webViewController!.canGoForward()) {
                await _webViewController!.goForward();
              }
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          InAppWebView(
            initialUrlRequest:
                URLRequest(url: Uri.parse("https://www.google.co.in")),
            onWebViewCreated: (controller) {
              _webViewController = controller;
            },
            pullToRefreshController: pullToRefreshController,
            onLoadStart: (controller, uri) {},
            onLoadStop: (controller, uri) async {
              await pullToRefreshController.endRefreshing();
            },
            initialOptions: options,
            androidOnPermissionRequest: (controller, origin, resources) async {
              return PermissionRequestResponse(
                  resources: resources,
                  action: PermissionRequestResponseAction.GRANT);
            },
            onProgressChanged: (controller, val) {
              if (val == 100) {
                pullToRefreshController.endRefreshing();
              }
              setState(() {
                progress = val / 100;
              });
            },
          ),
          (progress < 1)
              ? LinearProgressIndicator(value: progress)
              : Container(),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            child: const Icon(Icons.favorite),
            onPressed: () async {
              Uri? url = await _webViewController!.getUrl();
              bookmarks.add(url!.path);
            },
          ),
          const SizedBox(width: 15),
          FloatingActionButton(
            child: const Icon(Icons.apps),
            onPressed: () async {
              print(bookmarks);
            },
          ),
        ],
      ),
    );
  }
}
