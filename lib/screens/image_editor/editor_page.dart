
import 'dart:io';

import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:visiting_card/screens/image_editor/effects.dart';
import 'package:visiting_card/screens/image_editor/text_info.dart';
import 'package:visiting_card/screens/image_editor/utils.dart';
import 'package:visiting_card/screens/image_editor/image_text.dart';

class EditorPage extends StatefulWidget {
  final File? imageBg;
  const EditorPage({Key? key,this.imageBg}) : super(key: key);

  @override
  State<EditorPage> createState() => _EditorPageState();
}

class _EditorPageState extends State<EditorPage> {
  File? image;
  TextEditingController textEditingController = TextEditingController();
  TextEditingController creatorText = TextEditingController();
  ScreenshotController screenshotController = ScreenshotController();

  List<TextInfo> texts = [];
  int currentIndex = 0;
  final Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  // @override
  // void initState(){
  //   super.initState();
  //   initPref();
  // }
  // void initPref() async{
  //   prefs = await SharedPreferences.getInstance();
  // }
  Future<File?> cropimage({required File imagefile}) async {
    CroppedFile? croppedimage =
    await ImageCropper().cropImage(sourcePath: imagefile.path);
    if (croppedimage == null) return null;
    return File(croppedimage.path);
  }

  saveToGallery(BuildContext context) {
    if (texts.isNotEmpty) {
      screenshotController.capture().then((Uint8List? image) {
        saveImage(image!);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Image saved to gallery.'),
          ),
        );
      }).catchError((err) => print(err));
    }
  }

  saveImage(Uint8List bytes) async {
    final time = DateTime.now()
        .toIso8601String()
        .replaceAll('.', '-')
        .replaceAll(':', '-');
    final name = "screenshot_$time";
    await requestPermission(Permission.storage);
    await ImageGallerySaver.saveImage(bytes, name: name);
  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;

      File? imageTemp = File(image.path);
      // imageTemp = await cropimage(imagefile: imageTemp);

      setState(() => this.image = imageTemp);

      // Navigator.pop(context);
    } on PlatformException {
      // ignore: avoid_print
      // print('Failed to pick image: $e');
    }
  }

  Future pickImage2() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;

      File? imageTemp = File(image.path);
      // imageTemp = await cropimage(imagefile: imageTemp);

      setState(() => this.image = imageTemp);

      Navigator.pop(context);
    } on PlatformException {
      // ignore: avoid_print
      // print('Failed to pick image: $e');
    }
  }

  Future pickImageC() async {
    try {
      final XFile? image =
      await ImagePicker().pickImage(source: ImageSource.camera);

      if (image == null) return;

      final imageTemp = File(image.path);

      setState(() => this.image = imageTemp);
      // ignore: empty_catches
    } on PlatformException {}
  }

  Future pickImageC2() async {
    try {
      final XFile? image =
      await ImagePicker().pickImage(source: ImageSource.camera);

      if (image == null) return;

      final imageTemp = File(image.path);

      setState(() => this.image = imageTemp);
      Navigator.pop(context);
      // ignore: empty_catches
    } on PlatformException {}
  }

  editText2(BuildContext context, int index) {
    setState(() {
      texts.removeAt(index);
      texts.add(
        TextInfo(
          text: textEditingController.text,
          left: 150,
          top: 330,
          color: Colors.black,
          fontWeight: FontWeight.normal,
          fontStyle: FontStyle.normal,
          fontSize: 40,
          textAlign: TextAlign.center,
        ),
      );
      Navigator.of(context)
      // ..pop()
        ..pop();
    });
  }

  addNewText2(BuildContext context) {
    setState(() {
      texts.add(
        TextInfo(
          text: textEditingController.text,
          left: 150,
          top: 330,
          color: Colors.black,
          fontWeight: FontWeight.normal,
          fontStyle: FontStyle.normal,
          fontSize: 40,
          textAlign: TextAlign.center,
        ),
      );
      Navigator.of(context)
      // ..pop()
        ..pop();
    });
  }

  addNewDialog2(context, {edit = false, int? index}) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text(
          'Add New Text',
        ),
        content: TextField(
          controller: textEditingController,
          maxLines: 5,
          decoration: const InputDecoration(
            suffixIcon: Icon(
              Icons.edit,
            ),
            filled: true,
            hintText: 'Your Text Here..',
          ),
        ),
        actions: <Widget>[
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
              textStyle: MaterialStateProperty.all<TextStyle>(
                const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            onPressed: () => Navigator.of(context)
            // ..pop()
              ..pop(),
            child: const Text('Back'),
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
              textStyle: MaterialStateProperty.all<TextStyle>(
                const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            onPressed: () =>
            (edit) ? editText2(context, index!) : addNewText2(context),
            child: const Text('Add Text'),
          ),
        ],
      ),
    );
  }

  removeText(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text(
          'Are you sure you want to delete?',
        ),
        actions: <Widget>[
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
              textStyle: MaterialStateProperty.all<TextStyle>(
                const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            onPressed: () => Navigator.of(context)
            // ..pop()
              ..pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
              textStyle: MaterialStateProperty.all<TextStyle>(
                const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            onPressed: () {
              setState(() {
                texts.removeAt(currentIndex);
              });
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Text Deleted',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ),
              );
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    // );
  }

  setCurrentIndex(BuildContext context, index) {
    setState(() {
      currentIndex = index;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Selected For Styling',
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }

  increaseFontSize() {
    setState(() {
      texts[currentIndex].fontSize += 2;
    });
  }

  decreaseFontSize() {
    setState(() {
      texts[currentIndex].fontSize -= 2;
    });
  }

  changeTextColor(Color color) {
    setState(() {
      texts[currentIndex].color = color;
      Navigator.of(context)
        ..pop()
        ..pop();
    });
  }

  Future<File?> _cropImage111({required File imagefile}) async {
    if (imagefile != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: imagefile.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: 'Cropper',
          ),
          WebUiSettings(
            context: context,
            presentStyle: CropperPresentStyle.dialog,
            boundary: const CroppieBoundary(
              width: 520,
              height: 520,
            ),
            viewPort:
            const CroppieViewPort(width: 480, height: 480, type: 'circle'),
            enableExif: true,
            enableZoom: true,
            showZoomer: true,
          ),
        ],
      );
      if (croppedFile == null) return null;
      return File(croppedFile.path);
      // if (croppedFile != null) {
      //   setState(() {
      //     _croppedFile = croppedFile;
      //   });
      // }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    print('image:$image');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        actions: <Widget>[
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () async {
                  print('crop');
                  // _cropImage111();
                  File? imageTemp = File(image!.path);
                  imageTemp = await _cropImage111(imagefile: imageTemp);

                  setState(() => image = imageTemp);
                },
                child: const Icon(
                  Icons.crop,
                  size: 26.0,
                ),
              )),
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  saveToGallery(context);
                },
                child: const Icon(
                  Icons.save,
                  size: 26.0,
                ),
              )),
          Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: GestureDetector(
                onTap: () {
                  showAlignedDialog(
                      context: context,
                      builder: _localDialogBuilder,
                      followerAnchor: Alignment.topLeft,
                      targetAnchor: Alignment.topRight,
                      barrierColor: Colors.transparent,
                      avoidOverflow: true);
                },
                child: const Icon(Icons.edit),
              )),
          Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: GestureDetector(
                onTap: () {
                  showAlignedDialog(
                      context: context,
                      builder: _localDialogBuilder2,
                      followerAnchor: Alignment.topLeft,
                      targetAnchor: Alignment.topRight,
                      barrierColor: Colors.transparent,
                      avoidOverflow: true);
                },
                child: const Icon(Icons.more_vert),
              )),
        ],
      ),
      body: Screenshot(
        controller: screenshotController,
        child: SafeArea(
          child: Container(
            margin: const EdgeInsets.only(
              top: 0.0,
            ),
            // width: MediaQuery.of(context).size.width,
            // height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                Center(
                  child: image != null
                      ? Image.file(
                    image!,
                    fit: BoxFit.fill,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                  )
                      : Image.network(
                    'https://static.wikia.nocookie.net/just-because/images/0/0c/NoImage_Available.png/revision/latest?cb=20170601005615',
                    fit: BoxFit.fill,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                  ),
                ),
                for (int i = 0; i < texts.length; i++)
                  Positioned(
                    left: texts[i].left,
                    top: texts[i].top,
                    child: GestureDetector(
                      onLongPress: () {
                        setState(() {
                          currentIndex = i;
                          removeText(context);
                        });
                      },
                      onTap: () => setCurrentIndex(context, i),
                      child: Draggable(
                        feedback: Material(color:Colors.transparent,
                            child: ImageText(textInfo: texts[i])),
                        childWhenDragging: Container(),
                        onDragEnd: (drag) {
                          final renderBox =
                          context.findRenderObject() as RenderBox;
                          Offset off = renderBox.globalToLocal(drag.offset);
                          setState(() {
                            texts[i].top = off.dy - 96;
                            texts[i].left = off.dx;
                          });
                        },
                        child: ImageText(textInfo: texts[i]),
                      ),
                    ),
                  ),
                creatorText.text.isNotEmpty
                    ? Positioned(
                  left: 0,
                  bottom: 0,
                  child: Text(
                    creatorText.text,
                    style: TextStyle(
                        fontSize: 0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black.withOpacity(
                          0.3,
                        )),
                  ),
                )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
        ),
      ),
    );
    // ignore: unnecessary_cast
  }

  WidgetBuilder get _localDialogBuilder2 {
    return (BuildContext context) {
      return GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Container(
          margin: const EdgeInsets.only(
            top: 80,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: DefaultTextStyle(
            style: const TextStyle(fontSize: 18, color: Colors.black87),
            child: IntrinsicWidth(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                      onTap: () {
                        pickImage2();
                      },
                      child: const Text("Gallery")),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    height: 4,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                      onTap: () {
                        pickImageC2();
                        //Navigator.of(context).pop();
                      },
                      child: const Text("Camera")),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  const SizedBox(
                    height: 10,
                  ),
                  // const Divider(
                  //   height: 4,
                  // ),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  // GestureDetector(
                  //     onTap: () {
                  //       {
                  //         File? file = image;
                  //         // if (file != null) {
                  //         //   Navigator.of(context).push(
                  //         //     MaterialPageRoute(
                  //         //       builder: (context) => AdvancedExample(
                  //         //         selectedImage: file.path,
                  //         //       ),
                  //         //     ),
                  //         //   );
                  //         // }
                  //       }
                  //       //Navigator.of(context).pop();
                  //     },
                  //     child: const Text("Stickers")),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  // const Divider(
                  //   height: 4,
                  // ),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  // GestureDetector(
                  //     onTap: () async{
                  //       {
                  //         File? file = image;
                  //         // print('image selected:${image!.path}');
                  //         // final SharedPreferences _prefs = await prefs;
                  //         // var tempImage = '';
                  //         // setState(() {
                  //         //   tempImage = _prefs.setString(AppStrings.ktempImage, image!.path).toString();
                  //         //   print('get image:${_prefs.get(AppStrings.ktempImage)}');
                  //         // });
                  //         if (file != null) {
                  //           Navigator.of(context).push(
                  //             MaterialPageRoute(
                  //               builder: (context) => Effects(
                  //                 selectedImage: file,
                  //                 // selectedImage: _prefs.getString(AppStrings.ktempImage),
                  //               ),
                  //             ),
                  //           );
                  //         }
                  //       }
                  //       //Navigator.of(context).pop();
                  //     },
                  //     child: const Text("Effects")),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                ],
              ),
            ),
          ),
        ),
      );
    };
  }

  WidgetBuilder get _localDialogBuilder {
    return (BuildContext context) {
      return GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Container(
          margin: const EdgeInsets.only(
            top: 80,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: DefaultTextStyle(
            style: const TextStyle(fontSize: 18, color: Colors.black87),
            child: IntrinsicWidth(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                      onTap: () {
                        addNewDialog2(context);
                      },
                      child: const Text("Text-write")),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    height: 4,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                      onTap: () {
                        increaseFontSize();
                        //Navigator.of(context).pop();
                      },
                      child: const Text("Text-increase")),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    height: 4,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                      onTap: () {
                        decreaseFontSize();
                        //Navigator.of(context).pop();
                      },
                      child: const Text("Text-decrease")),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    height: 4,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text(
                              'Change Color',
                            ),
                            actions: <Widget>[
                              SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    ListView.separated(
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemCount: 20,
                                      separatorBuilder: (_, __) => const Divider(),
                                      itemBuilder: (context, int index) {
                                        return Container(
                                          margin:
                                          const EdgeInsets.only(top: 0, left: 10),
                                          height: 30,
                                          width: 30,
                                          child: GestureDetector(
                                              onTap: () =>
                                                  changeTextColor(Colors.red.shade50),
                                              child: CircleAvatar(
                                                backgroundColor: Colors.red.shade50,
                                              )),
                                        );
                                      },
                                    ),
                                    Container(
                                      margin:
                                      const EdgeInsets.only(top: 0, left: 10),
                                      height: 30,
                                      width: 30,
                                      child: GestureDetector(
                                          onTap: () =>
                                              changeTextColor(Colors.yellow.shade50),
                                          child: CircleAvatar(
                                            backgroundColor: Colors.yellow.shade50,
                                          )),
                                    ),
                                    Container(
                                      margin:
                                      const EdgeInsets.only(top: 0, left: 10),
                                      height: 30,
                                      width: 30,
                                      child: GestureDetector(
                                          onTap: () =>
                                              changeTextColor(Colors.purple),
                                          child: const CircleAvatar(
                                            backgroundColor: Colors.purple,
                                          )),
                                    ),
                                    Container(
                                      margin:
                                      const EdgeInsets.only(top: 0, left: 10),
                                      height: 30,
                                      width: 30,
                                      child: GestureDetector(
                                          onTap: () =>
                                              changeTextColor(Colors.pink),
                                          child: const CircleAvatar(
                                            backgroundColor: Colors.pink,
                                          )),
                                    ),
                                    Container(
                                      margin:
                                      const EdgeInsets.only(top: 0, left: 10),
                                      height: 30,
                                      width: 30,
                                      child: GestureDetector(
                                          onTap: () =>
                                              changeTextColor(Colors.green),
                                          child: const CircleAvatar(
                                            backgroundColor: Colors.green,
                                          )),
                                    ),
                                    Container(
                                      margin:
                                      const EdgeInsets.only(top: 0, left: 10),
                                      height: 30,
                                      width: 30,
                                      child: GestureDetector(
                                          onTap: () =>
                                              changeTextColor(Colors.black),
                                          child: const CircleAvatar(
                                            backgroundColor: Colors.black,
                                          )),
                                    ),
                                    Container(
                                      margin:
                                      const EdgeInsets.only(top: 0, left: 10),
                                      height: 30,
                                      width: 30,
                                      child: GestureDetector(
                                          onTap: () =>
                                              changeTextColor(Colors.blue),
                                          child: const CircleAvatar(
                                            backgroundColor: Colors.blue,
                                          )),
                                    ),
                                    Container(
                                      margin:
                                      const EdgeInsets.only(top: 0, left: 10),
                                      height: 30,
                                      width: 30,
                                      child: GestureDetector(
                                          onTap: () =>
                                              changeTextColor(Colors.red),
                                          child: const CircleAvatar(
                                            backgroundColor: Colors.red,
                                          )),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                        //Navigator.of(context).pop();
                      },
                      child: const Text("Text-color")),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    };
  }
}