
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:path_provider/path_provider.dart';

class Web extends StatefulWidget {
  @override
  _WebState createState() => new _WebState();
}

class _WebState extends State<Web> {
  late InAppWebViewController webView;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('InAppWebView Example'),
        ),
        body: Container(
            child: Column(children: <Widget>[
              Expanded(
                  child: InAppWebView(
                    // initialData: URLRequest(url: Uri.parse("http://ovh.net/files/1Mio.dat")),
                    initialUrlRequest: URLRequest(
                        url:
                        // Uri.parse('https://visitmysite.in/pixie/index.html')
                        Uri.parse('http://ovh.net/files/1Mio.dat')
                      // url: Uri.parse('https://visitmysite.in/editor/index.html')
                      // url: Uri.parse("https://codepen.io/AaradhyaThakkar/pen/eYLXOMo?editors=0010")
                    ),
                    // initialHeaders: {},
                    initialOptions: InAppWebViewGroupOptions(
                      crossPlatform: InAppWebViewOptions(
                          // debuggingEnabled: true,
                          useOnDownloadStart: true
                      ),
                    ),
                    onWebViewCreated: (InAppWebViewController controller) {
                      webView = controller;
                    },
                    // onLoadStart: (InAppWebViewController controller, String url) {
                    //
                    // },
                    // onLoadStop: (InAppWebViewController controller, String url) {
                    //
                    // },
                    onDownloadStart: (controller, url) async {
                      print("onDownloadStart $url");
                      final taskId = await FlutterDownloader.enqueue(
                        url: url.toString(),
                        savedDir: (await getExternalStorageDirectory())!.path,
                        saveInPublicStorage: true,
                        showNotification: true, // show download progress in status bar (for Android)
                        openFileFromNotification: true, // click on notification to open downloaded file (for Android)
                      );
                    },
                  ))
            ])),
      ),
    );
  }
}