import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:visiting_card/screens/splash_screen.dart';

final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
bool isStoragePermission = true;
bool isVideosPermission = true;
bool isPhotosPermission = true;

class DownloadClass{
  static void callback(String id,DownloadTaskStatus status, int progress){
    print('Download Status: $status');
    print('Download Progress: $progress');
  }
}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(
      debug: true // optional: set false to disable printing logs to console
  );
  // FlutterDownloader.registerCallback(DownloadClass.callback);
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarBrightness: Brightness.light,
    statusBarColor: Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.light
  ));
  if (Platform.isAndroid) {
    // await AndroidWebStorageManager();
    await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
  }
  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');

  final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      // onSelectNotification: (String payload) async {
      //   if (payload != null) {
      //     debugPrint('notification payload: $payload');
      //   }
      // }
      );


  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
  if(androidInfo.version.sdkInt >= 33 ? (await Permission.videos.status.isGranted && await Permission.photos.status.isGranted) : await Permission.storage.status.isGranted){
    if (androidInfo.version.sdkInt >= 33) {
      print("Testing version" + androidInfo.version.sdkInt.toString());
      isVideosPermission = await Permission.videos.status.isGranted;
      isPhotosPermission = await Permission.photos.status.isGranted;
    } else {
      isStoragePermission = await Permission.storage.status.isGranted;
    }
  }
  else{
    print(" else Testing version" + androidInfo.version.sdkInt.toString());
    openAppSettings();
  }
  // enableFlutterDriverExtension();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Visiting Card',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return const Scaffold(
      // appBar: AppBar(
      //   // Here we take the value from the MyHomePage object that was created by
      //   // the App.build method, and use it to set our appbar title.
      //   title: Text(widget.title),
      // ),
      body: SplashScreenView(),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
