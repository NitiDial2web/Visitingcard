import 'package:flutter/material.dart';
import 'package:visiting_card/screens/edit_page.dart';

class InnerPage extends StatefulWidget {
  final String image;
  final bool portrait;
  final String? filename;
  final String? category;
  const InnerPage({Key? key, required this.image,this.portrait = false, this.filename, this.category}) : super(key: key);

  @override
  State<InnerPage> createState() => _InnerPageState();
}

class _InnerPageState extends State<InnerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.5,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Color(0xFF741a8a),
                      Color(0xFFa66191)
                    ],
                    // Gradient from https://learnui.design/tools/gradient-generator.html
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                      child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.close,
                            size: 40,
                          )),
                    )
                  ],
                ),
              ),
              Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.45,
                color: Colors.white,
              )
            ],
          ),
          Center(
            child: Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.9,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.red,
                image: DecorationImage(
                    image: NetworkImage(widget.image),
                    fit: BoxFit.fill,
                  ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: GestureDetector(
              onTap: () {
                print('edit');
                Navigator.push(context, MaterialPageRoute(builder: (context)=> EditPage(image: widget.filename!, categoryName: widget.category!,)));
              },
              child: Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                height: 70,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Color(0xFF741a8a),
                      Color(0xFFa66191)
                    ],
                    // Gradient from https://learnui.design/tools/gradient-generator.html
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.edit,
                      size: 25,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      'EDIT',
                      style:
                      TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
