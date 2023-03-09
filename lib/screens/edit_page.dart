import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html_to_pdf/flutter_html_to_pdf.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:visiting_card/common/AppColors.dart';
import 'package:visiting_card/screens/settings_page.dart';

class EditPage extends StatefulWidget {
  final String image;
  final String categoryName;
  const EditPage({Key? key, required this.image, required this.categoryName}) : super(key: key);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  late InAppWebViewController _controller;

  convert(String cfData, String name) async {  // Name is File Name that you want to give the file
    var targetPath = await _localPath;
    var targetFileName = name;

    var generatedPdfFile = await FlutterHtmlToPdf.convertFromHtmlContent(
        cfData, targetPath!, targetFileName);
    print('generatedPdfFile:$generatedPdfFile');
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(generatedPdfFile.toString()),
    ));
  }
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

  @override
  Widget build(BuildContext context) {
    print(widget.image);
    print(widget.image.split('.').last);
    print(widget.image.replaceRange(widget.image.length-3, widget.image.length, 'html'));
    print('https://visitmysite.in/visitingcard/public/featured/${widget.image}.html');
    print('https://visitmysite.in/visitingcard/public/visiting_card_html/${widget.categoryName}/${widget.image}.html');
    return Scaffold(
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
              onTap: ()async{
                print('Download');
                print('url:${await _controller.evaluateJavascript(source: "window.document.URL;")}');
                print('niti hello${DateTime.now().hour}${DateTime.now().minute}${DateTime.now().second}');
                String html = await _controller.evaluateJavascript(source: "window.document.body.innerHTML;");
                print(html);
                convert(html,"File Name${DateTime.now().toString().split(' ').first}${DateTime.now().hour}${DateTime.now().minute}${DateTime.now().second}");
                var targetPath2 = await _localPath;
                File pdfFile() {
                  if (Platform.isIOS) {
                    return  File(targetPath2.toString()+"/"+ "File Name333" + '.pdf'); // for ios
                  }
                  else
                  {
                    print("aaaaa "+targetPath2.toString());
                    // File('storage/emulated/0/Download/' + cfData + '.pdf')
                    return File(targetPath2.toString()+"/"+ "File Name" + '.pdf'); // for android
                  }
                }
                SfPdfViewer.file(
                    pdfFile()
                );
                // generateExampleDocument();
                print('download_successfull..//:');
                // Navigator.push(context, MaterialPageRoute(builder: (context)=> const AppsStorePage()));
              },
              child: Icon(Icons.download),
            ),
          )
        ],
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: Uri.parse('https://visitmysite.in/visitingcard/public/visiting_card_html/${widget.categoryName}/${widget.image}.html')),
        // initialHeaders: {},
        initialOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(
            // debuggingEnabled: true,
              useOnDownloadStart: true,
              allowFileAccessFromFileURLs: true,
              allowUniversalAccessFromFileURLs: true
          ),
          android: AndroidInAppWebViewOptions(
            useHybridComposition: true,
          ),
        ),
        // gestureNavigationEnabled: true,
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
            (InAppWebViewController webViewController) {
          _controller = webViewController;
        },
//                       onLoadStop: (controller, url) async {
//                         if(await _controller.evaluateJavascript(source: "window.document.URL;") != "https://qswappweb.com/resumebuilder/public/featured"){
//                               // var result = await controller.evaluateJavascript(
//                               //     source: "1 + 1");
//                               // print(result.runtimeType); // int
//                               // print(result); //2
//                           var result = _controller.evaluateJavascript(source: '''
//   var fileInput = document.createElement('input');
//   fileInput.type = 'file';
//   fileInput.accept = 'image/*';
//   fileInput.onchange = () => {
//     var file = fileInput.files[0];
//     var reader = new FileReader();
//     reader.readAsDataURL(file);
//     reader.onload = () => {
//       window.flutter_injector.get('ImagePicker').invokeMethod('pickImage', reader.result);
//     };
//   };
//   fileInput.click();
// ''');
//                           print(result.toString());
//                           print(result);
//                         }
//                       },
        // onWebViewCreated: (InAppWebViewController controller) {
        //   webView = controller;
        // },
        // onLoadStart: (InAppWebViewController controller, String url) {
        //
        // },
        // onLoadStop: (InAppWebViewController controller, String url) {
        //
        // },
        // onLoadStop: (controller, url) async {
        //   var html = await controller.evaluateJavascript(
        //       source: "window.document.getElementsByTagName('head')[0].outerHTML;");
        //   //   source: "window.document.body.innerText;");
        //   print("==========start================");
        //   // catchtext = html;
        //   print(':$html}');
        //
        // },

        // onPageCommitVisible: (con,uri){
        //   print("url ${uri.toString()}");
        //   con.goBack();
        // },
        // onDownloadStartRequest: (controller, url) async {
        //   print('Permission.storage.status:${await Permission.storage.status}');
        //   // await checkPermission();
        //   // print(await checkPermission());
        //   print("onDownloadStart $url");
        //   if(await Permission.storage.request().isGranted){
        //     print('if true');
        //         final taskId = await FlutterDownloader.enqueue(
        //           url: 'https:\/\/qswappweb.com\/resumebuilder\/public\/uploads\/user_guide_image\/63b3eed2d1cef.png',
        //               // 'https://qswappweb.com/resumebuilder/public/featured',
        //           saveInPublicStorage: true,
        //           savedDir:
        //               (await getExternalStorageDirectory())!.path,
        //           showNotification: true,
        //           fileName: "Flamingo Order Details",
        //           // show download progress in status bar (for Android)
        //           openFileFromNotification:
        //               true, // click on notification to open downloaded file (for Android)
        //         );
        //         print('taskId:$taskId');
        //       }
        //   else{
        //     print('else false');
        //     checkPermission();
        //   }
        //     },
      ),
    );
  }
}
