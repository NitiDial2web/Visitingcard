import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:visiting_card/common/AppColors.dart';
import 'package:visiting_card/common/AppStrings.dart';
import 'package:visiting_card/models/get_category_image.dart';

class CategoriesPage extends StatefulWidget {
  final List? image;
  const CategoriesPage({Key? key, required this.image}) : super(key: key);

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {

  Future<getCategoryImage?> getcategoryImage() async {
    // preferences = await SharedPreferences.getInstance();
    try {
      final response = await http.get(
        Uri.parse(AppStrings.kGetCategoryImageUrl),
        // body: {"users_id": preferences.getString(AppStrings.kPrefUserIdKey)}
      );

      var responseData = jsonDecode(response.body);
      print('response apps  $responseData');
      print('response.statusCode:${response.statusCode}');
      if (response.statusCode == 200) {
        if (responseData['success'] == 1) {
          var _usersData = responseData['data'];
          // for (int i = 0; i < _usersData.length; i++) {
          // _videos.add(_usersData[i]['video']);
          // }
          // print('_videos :$_videos');
          return getCategoryImage.fromJson(responseData);
        } else {
          print("else responseData['status'] :${responseData['status']}");
          // AppCommon.showToast(responseData["message"]);
        }
      } else {
        throw Exception('Failed to load data');
      }
    } catch (exception) {
      print('exception getHomeImages $exception');
    }
    // return null;
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: FutureBuilder<getCategoryImage?>(
        future: getcategoryImage(),
        builder: (BuildContext context,AsyncSnapshot<getCategoryImage?> snapshot){
          if(!snapshot.hasData){
            print('if');
            return const Center(child: CircularProgressIndicator());
          }
          else{
            return ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: 10,
                itemBuilder: (_, index) {
                  print('image: ${widget.image!}');
                  return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: GestureDetector(
                        onTap: () {
                          print('see more1111');
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => InnerPage(image: snapshot.data!.data![1]!.list![index]!.image.toString(),)));
                        },
                        child: Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.8,
                          height: 130,
                          decoration: BoxDecoration(
                            color: Colors.lightBlue,
                            // image: DecorationImage(
                            //   image: NetworkImage(image[index]),
                            //   fit: BoxFit.cover,
                            // ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.kDarkGrey,
                                // offset: Offset(0.0, 0),
                                blurRadius: 5,
                                // spreadRadius: 0.0,
                              ), //BoxShadow
                            ],
                          ),
                          // child: Text('$index'),
                        ),
                      ));
                });
          }
        },
      ),
    );
  }
}
