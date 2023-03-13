import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_html_to_pdf/flutter_html_to_pdf.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:visiting_card/common/AppColors.dart';
import 'package:visiting_card/screens/app_store.dart';
import 'package:visiting_card/screens/settings_page.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late WebViewController _controller;
  // late InAppWebViewController _controller;
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

  // convert(String cfData, String name) async {  // Name is File Name that you want to give the file
  //   var targetPath = await _localPath;
  //   var targetFileName = name;
  //
  //   var generatedPdfFile = await FlutterHtmlToPdf.convertFromHtmlContent(
  //       cfData, targetPath!, targetFileName);
  //   print('generatedPdfFile:$generatedPdfFile');
  //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //     content: Text(generatedPdfFile.toString()),
  //   ));
  // }
  Future<String?> get _localPath async {
    Directory? directory;
    try {
      if (Platform.isIOS) {
        directory = await getApplicationSupportDirectory();
      } else {   // if platform is android
        directory = Directory('/storage/emulated/0/Download');
        if (!await directory.exists()) {
          directory = await getExternalStorageDirectory();
        }
      }
    } catch (err, stack) {
      print("Can-not get download folder path");
    }
    return directory?.path;
  }

  Future<void> generateExampleDocument() async {
    print('generateExampleDocument');


    // Directory appDocDir = await getApplicationDocumentsDirectory();
    // print('path:$appDocDir');
    // final targetPath = 'example_resume/';
    // final targetFileName = "example-pdf";
    //
    // final generatedPdfFile = await FlutterHtmlToPdf.convertFromHtmlContent(htmlContent, targetPath, targetFileName);
    // generatedPdfFilePath = generatedPdfFile.path;
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
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> const AppsStorePage()));
                },
                child: Image.asset(
                  'assets/images/Web_Advertising.png',
                  width: 25,
                  height: 25,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: GestureDetector(
                onTap: ()async{
                  // print('Download');
                  // print('url:${await _controller.evaluateJavascript(source: "window.document.URL;")}');
                  // print('niti hello${DateTime.now().hour}${DateTime.now().minute}${DateTime.now().second}');
                  // String html = await _controller.evaluateJavascript(source: "window.document.body.innerHTML;");
                  // print(html);
                  // convert(html,"File Name${DateTime.now().toString().split(' ').first}${DateTime.now().hour}${DateTime.now().minute}${DateTime.now().second}");
                  // var targetPath2 = await _localPath;
                  // File pdfFile() {
                  //   if (Platform.isIOS) {
                  //     return  File(targetPath2.toString()+"/"+ "File Name333" + '.pdf'); // for ios
                  //   }
                  //   else
                  //   {
                  //     print("aaaaa "+targetPath2.toString());
                  //     // File('storage/emulated/0/Download/' + cfData + '.pdf')
                  //     return File(targetPath2.toString()+"/"+ "File Name" + '.pdf'); // for android
                  //   }
                  // }
                  // SfPdfViewer.file(
                  //     pdfFile()
                  // );
                  // generateExampleDocument();
                  print('download_successfull..//:');
                  // Navigator.push(context, MaterialPageRoute(builder: (context)=> const AppsStorePage()));
                },
                child: Icon(Icons.download),
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
              initialUrl: 'https://visitmysite.in/visitingcard/public/featured',
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
//                 ?InAppWebView(
//                       initialUrlRequest: URLRequest(url: Uri.parse('https://visitmysite.in/visitingcard/public/featured')),
//                       // initialHeaders: {},
//                       initialOptions: InAppWebViewGroupOptions(
//                         crossPlatform: InAppWebViewOptions(
//                           // debuggingEnabled: true,
//                             useOnDownloadStart: true,
//                           allowFileAccessFromFileURLs: true,
//                           allowUniversalAccessFromFileURLs: true
//                         ),
//                         android: AndroidInAppWebViewOptions(
//                           useHybridComposition: true,
//                         ),
//                       ),
//                       // gestureNavigationEnabled: true,
//                           gestureRecognizers: Set()
//                             ..add(Factory<VerticalDragGestureRecognizer>(() =>
//                                 VerticalDragGestureRecognizer()
//                                   ..onDown =
//                                       (DragDownDetails dragDownDetails) {
//                                     _controller.getScrollY().then((value) {
//                                       if (value == 0 &&
//                                           dragDownDetails
//                                                   .globalPosition.direction <
//                                               1) {
//                                         _controller.reload();
//                                       }
//                                     });
//                                   }))
//                             ..add(Factory<LongPressGestureRecognizer>(() => LongPressGestureRecognizer())),
//                         onWebViewCreated:
//                                 (InAppWebViewController webViewController) {
//                               _controller = webViewController;
//                             },
// //                       onLoadStop: (controller, url) async {
// //                         if(await _controller.evaluateJavascript(source: "window.document.URL;") != "https://qswappweb.com/resumebuilder/public/featured"){
// //                               // var result = await controller.evaluateJavascript(
// //                               //     source: "1 + 1");
// //                               // print(result.runtimeType); // int
// //                               // print(result); //2
// //                           var result = _controller.evaluateJavascript(source: '''
// //   var fileInput = document.createElement('input');
// //   fileInput.type = 'file';
// //   fileInput.accept = 'image/*';
// //   fileInput.onchange = () => {
// //     var file = fileInput.files[0];
// //     var reader = new FileReader();
// //     reader.readAsDataURL(file);
// //     reader.onload = () => {
// //       window.flutter_injector.get('ImagePicker').invokeMethod('pickImage', reader.result);
// //     };
// //   };
// //   fileInput.click();
// // ''');
// //                           print(result.toString());
// //                           print(result);
// //                         }
// //                       },
//                       // onWebViewCreated: (InAppWebViewController controller) {
//                       //   webView = controller;
//                       // },
//                       // onLoadStart: (InAppWebViewController controller, String url) {
//                       //
//                       // },
//                       // onLoadStop: (InAppWebViewController controller, String url) {
//                       //
//                       // },
//                       // onLoadStop: (controller, url) async {
//                       //   var html = await controller.evaluateJavascript(
//                       //       source: "window.document.getElementsByTagName('head')[0].outerHTML;");
//                       //   //   source: "window.document.body.innerText;");
//                       //   print("==========start================");
//                       //   // catchtext = html;
//                       //   print(':$html}');
//                       //
//                       // },
//
//                       // onPageCommitVisible: (con,uri){
//                       //   print("url ${uri.toString()}");
//                       //   con.goBack();
//                       // },
//                       // onDownloadStartRequest: (controller, url) async {
//                       //   print('Permission.storage.status:${await Permission.storage.status}');
//                       //   // await checkPermission();
//                       //   // print(await checkPermission());
//                       //   print("onDownloadStart $url");
//                       //   if(await Permission.storage.request().isGranted){
//                       //     print('if true');
//                       //         final taskId = await FlutterDownloader.enqueue(
//                       //           url: 'https:\/\/qswappweb.com\/resumebuilder\/public\/uploads\/user_guide_image\/63b3eed2d1cef.png',
//                       //               // 'https://qswappweb.com/resumebuilder/public/featured',
//                       //           saveInPublicStorage: true,
//                       //           savedDir:
//                       //               (await getExternalStorageDirectory())!.path,
//                       //           showNotification: true,
//                       //           fileName: "Flamingo Order Details",
//                       //           // show download progress in status bar (for Android)
//                       //           openFileFromNotification:
//                       //               true, // click on notification to open downloaded file (for Android)
//                       //         );
//                       //         print('taskId:$taskId');
//                       //       }
//                       //   else{
//                       //     print('else false');
//                       //     checkPermission();
//                       //   }
//                       //     },
//                     )
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