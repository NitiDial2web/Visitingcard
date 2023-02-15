import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:visiting_card/common/AppColors.dart';
import 'package:visiting_card/screens/settings_page.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late WebViewController _controller;
  bool connectionStatus = true;
  Future check() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        connectionStatus = true;
      }
    } on SocketException catch (_) {
      connectionStatus = false;
    }
  }

  @override
  void initState() {
    super.initState();
    // internet();
    // #docregion platform_features
//     late final PlatformWebViewControllerCreationParams params;
//     if (WebViewPlatform.instance is WebKitWebViewPlatform) {
//       params = WebKitWebViewControllerCreationParams(
//         allowsInlineMediaPlayback: true,
//         mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
//       );
//     } else {
//       params = const PlatformWebViewControllerCreationParams();
//     }
//
//     final WebViewController controller =
//     WebViewController.fromPlatformCreationParams(params);
//     // #enddocregion platform_features
//
//     controller
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setBackgroundColor(const Color(0x00000000))
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           onProgress: (int progress) {
//             debugPrint('WebView is loading (progress : $progress%)');
//           },
//           onPageStarted: (String url) {
//             debugPrint('Page started loading: $url');
//           },
//           onPageFinished: (String url) {
//             debugPrint('Page finished loading: $url');
//           },
//           onWebResourceError: (WebResourceError error) {
//             print('''
// Page resource error: $error
//   code: ${error.errorCode}
//   description: ${error.description}
//   errorType: ${error.errorType}
//   isForMainFrame: ${error.isForMainFrame}
//           ''');
//           },
//           onNavigationRequest: (NavigationRequest request) {
//             if (request.url.startsWith('https://www.youtube.com/')) {
//               debugPrint('blocking navigation to ${request.url}');
//               return NavigationDecision.prevent;
//             }
//             debugPrint('allowing navigation to ${request.url}');
//             return NavigationDecision.navigate;
//           },
//         ),
//       )
//       ..addJavaScriptChannel(
//         'Toaster',
//         onMessageReceived: (JavaScriptMessage message) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text(message.message)),
//           );
//         },
//       )
//       ..loadRequest(Uri.parse('https://youtube.com'));
//
//     // #docregion platform_features
//     if (controller.platform is AndroidWebViewController) {
//       AndroidWebViewController.enableDebugging(true);
//       (controller.platform as AndroidWebViewController)
//           .setMediaPlaybackRequiresUserGesture(false);
//     }
    // #enddocregion platform_features

    // _controller = controller;
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if(await _controller.canGoBack()){
          print('niti');
          _controller.goBack();
          return false;
        }
        else{
          print('niti else');
          return true;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.kAppBarColor,
          centerTitle: true,
          // title: AppButtons().kTextNormal(title: 'Build CV Resume Creator', fontSize: 20, fontWeight: FontWeight.bold, fontColor: AppColors.kWhite),
          leading: IconButton(
            icon: const Icon(Icons.settings, size: 25),
            color: AppColors.koffWhite,
            onPressed: () {
              print('settings clicked');
              Navigator.push(context, MaterialPageRoute(builder: (context)=> const SettingsPage()));
            },
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: GestureDetector(
                onTap: (){
                  print('Ads');
                  // Navigator.push(context, MaterialPageRoute(builder: (context)=> const AppsStorePage()));
                },
                child: Image.asset(
                  'assets/images/Web_Advertising.png',
                  width: 25,
                  height: 25,
                ),
              ),
            )
          ],
        ),
        body: FutureBuilder(
          future: check(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            print('connectionStatus: $connectionStatus');
            return (connectionStatus == true)
                ? WebView(
              // key: webViewKey,
              initialUrl: 'https://www.geeksforgeeks.org/',
              javascriptMode: JavascriptMode.unrestricted,
              onWebResourceError: (WebResourceError error) {
                print("WebresourceError occured!");
                // setState(() {
                //   appBarColor = Colors.red;
                //
                // });
              },
              gestureNavigationEnabled: true,
              gestureRecognizers: Set()
                ..add(Factory<VerticalDragGestureRecognizer>(() =>
                VerticalDragGestureRecognizer()
                  ..onDown =
                      (DragDownDetails dragDownDetails) {
                    _controller.getScrollY().then((value) {
                      if (value == 0 &&
                          dragDownDetails
                              .globalPosition.direction <
                              1) {
                        _controller.reload();
                      }
                    });
                  }))
                ..add(Factory<LongPressGestureRecognizer>(() => LongPressGestureRecognizer())),
              onWebViewCreated:
                  (WebViewController webViewController) {
                _controller = webViewController;
              },
            )
                : Center(
              child: Text(" no internet"),
            );
          },
        ),
        // body: DefaultTabController(
        //   length: 3,
        //   initialIndex: 0,
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.start,
        //     children: <Widget>[
        //       Material(
        //         color: AppColors.kTabColor,
        //         child: TabBar(
        //           indicatorColor: Colors.green,
        //           tabs: const [
        //             Tab(
        //               text: "FEATURED",
        //             ),
        //             Tab(
        //               text: "CATEGORIES",
        //             ),
        //             Tab(
        //               text: "MY DESIGN",
        //             ),
        //           ],
        //           labelColor: AppColors.kWhite,
        //           unselectedLabelColor: AppColors.kWhite,
        //           indicatorPadding:
        //           const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        //           indicator: RectangularIndicator(
        //               bottomLeftRadius: 20,
        //               bottomRightRadius: 20,
        //               topLeftRadius: 20,
        //               topRightRadius: 20,
        //               color: AppColors.kGrey.withOpacity(0.17)),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
      ),
    );
  }
}