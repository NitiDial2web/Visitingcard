import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:visiting_card/common/AppButtons.dart';
import 'package:visiting_card/common/AppColors.dart';
import 'package:visiting_card/common/AppStrings.dart';
import 'package:visiting_card/screens/image_editor/text_info.dart';
import 'package:visiting_card/screens/image_editor/image_text.dart';
import 'package:visiting_card/screens/image_editor/utils.dart';

class DesignCreate extends StatefulWidget {
  const DesignCreate({Key? key}) : super(key: key);

  @override
  State<DesignCreate> createState() => _DesignCreateState();
}

class _DesignCreateState extends State<DesignCreate> {
  TextEditingController textEditingController = TextEditingController();
  ScreenshotController screenshotController = ScreenshotController();
  List<TextInfo> texts = [];
  int currentIndex = 0;

  saveImage(Uint8List bytes) async {
    final time = DateTime.now()
        .toIso8601String()
        .replaceAll('.', '-')
        .replaceAll(':', '-');
    final name = "screenshot_$time";
    await requestPermission(Permission.storage);
    await ImageGallerySaver.saveImage(bytes, name: name);
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
          // DefaultButton(
          //   onPressed: () => Navigator.of(context)
          //     ..pop()
          //     ..pop(),
          //   // ignore: sort_child_properties_last
          //   child: const Text('Back'),
          //   color: Colors.red,
          //   textColor: Colors.white,
          // ),
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
          // DefaultButton(
          //   onPressed: () => addNewText2(context),
          //   // ignore: sort_child_properties_last
          //   child: const Text('Add Text'),
          //   color: Colors.red,
          //   textColor: Colors.white,
          // ),
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
        // content: TextField(
        //   controller: textEditingController,
        //   maxLines: 5,
        //   decoration: const InputDecoration(
        //     suffixIcon: Icon(
        //       Icons.edit,
        //     ),
        //     filled: true,
        //     hintText: 'Your Text Here..',
        //   ),
        // ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: true,
        elevation: 2,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.save,
              color: Colors.black,
            ),
            onPressed: () => saveToGallery(context),
            tooltip: 'Save Image',
          ),
        ],
      ),
      body: Screenshot(
        controller: screenshotController,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Stack(
                children: [
                  Container(
                    color: AppColors.kGrey,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height - 200,
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
                        onTap: () {
                          // setCurrentIndex(context, i);
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Wrap(
                                  direction: Axis.vertical,
                                  children: const [
                                    ListTile(
                                      leading: Icon(Icons.share),
                                      title: Text('Share'),
                                    ),
                                    ListTile(
                                      leading: Icon(Icons.copy),
                                      title: Text('Copy Link'),
                                    ),
                                    ListTile(
                                      leading: Icon(Icons.edit),
                                      title: Text('Edit'),
                                    ),
                                  ],
                                );
                              });
                        },
                        onDoubleTap: () {
                          setState(() {
                            currentIndex = i;
                          });
                          addNewDialog2(context, edit: true, index: i);
                        },
                        child: Draggable(
                          feedback: ImageText(textInfo: texts[i]),
                          child: ImageText(textInfo: texts[i]),
                          onDragEnd: (drag) {
                            final renderBox =
                                context.findRenderObject() as RenderBox;
                            Offset off = renderBox.globalToLocal(drag.offset);
                            setState(() {
                              texts[i].top = off.dy - 96;
                              texts[i].left = off.dx;
                            });
                          },
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Positioned(
                bottom: 0,
                child: Container(
                  color: Colors.red,
                  width: MediaQuery.of(context).size.width,
                  height: 68,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        AppButtons().kTextwithIcon(
                            icon: FontAwesomeIcons.t,
                            title: AppStrings.kAddText,
                            onTap: () {
                              addNewDialog2(context);
                            }),
                        // AppButtons().kTextwithIcon(icon: FontAwesomeIcons.t, title: AppStrings.kAddText),
                        // AppButtons().kTextwithIcon(icon: FontAwesomeIcons.t, title: AppStrings.kAddText),
                        // AppButtons().kTextwithIcon(icon: FontAwesomeIcons.t, title: AppStrings.kAddText),
                        // AppButtons().kTextwithIcon(icon: FontAwesomeIcons.t, title: AppStrings.kAddText),
                        // AppButtons().kTextwithIcon(icon: FontAwesomeIcons.t, title: AppStrings.kAddText),
                        // AppButtons().kTextwithIcon(icon: FontAwesomeIcons.t, title: AppStrings.kAddText),
                        // AppButtons().kTextwithIcon(icon: FontAwesomeIcons.t, title: AppStrings.kAddText)
                      ],
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
