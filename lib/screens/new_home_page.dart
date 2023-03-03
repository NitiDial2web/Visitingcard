import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:visiting_card/common/AppButtons.dart';
import 'package:visiting_card/common/AppColors.dart';
import 'package:visiting_card/common/AppStrings.dart';
import 'package:visiting_card/models/get_category_image.dart';
import 'package:visiting_card/screens/app_store.dart';
import 'package:visiting_card/screens/categories_page.dart';
import 'package:visiting_card/screens/create_your_own.dart';
import 'package:visiting_card/screens/inner_page.dart';

class NewHomePage extends StatefulWidget {
  const NewHomePage({Key? key}) : super(key: key);

  @override
  State<NewHomePage> createState() => _NewHomePageState();
}

class _NewHomePageState extends State<NewHomePage> {

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
      // extendBodyBehindAppBar: true,
      // backgroundColor: Colors.red,
      appBar: AppBar(
        // backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(onPressed: (){
          print('settings');
        }, icon: const Icon(Icons.settings)),
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
        ],
      ),
      body: FutureBuilder<getCategoryImage?>(
        future: getcategoryImage(),
        builder: (BuildContext context,AsyncSnapshot<getCategoryImage?> snapshot){
          if(!snapshot.hasData){
            print('if');
            return const Center(child: CircularProgressIndicator());
          }
          else{
            print("art: ${snapshot.data!.data![1]!.list![1]!.id}");
            print('list: ${snapshot.data!.data![1]!.list}');
            print('category: ${snapshot.data!.data!.length}');
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppButtons().kTextBold(
                        title: AppStrings.kMyDesign,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        fontColor: AppColors.kBlack),
                    SizedBox(
                      height: 160,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: 4,
                          itemBuilder: (_, index) {
                            return (index != 0)
                                ? GestureDetector(
                                    onTap: () {
                                      print('object');
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.8,
                                        height: 130,
                                        decoration: const BoxDecoration(
                                          color: Colors.lightBlue,
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
                                      ),
                                    ),
                                  )
                                // : (snapshot.data!.data![0]!.list!.isEmpty)
                                // ?Container()
                            :GestureDetector(
                                    onTap: () {
                                      print('object111');
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const CreateYourOwnPage()));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        width: 200,
                                        height: 200,
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
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
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          // crossAxisAlignment: CrossAxisAlignment.center,
                                          children: const [
                                            FaIcon(FontAwesomeIcons.add),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              'Create Your Own',
                                              style: TextStyle(fontSize: 20),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                          }),
                    ),
                    // AppButtons().kHomeCategory(
                    //     title: AppStrings.kMyDesign,
                    //     context: context,
                    //     onTap: () {
                    //       print('see more');
                    //     },
                    //     onTap1: () {
                    //       print(AppStrings.kMyDesign);
                    //       Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //               builder: (context) => const InnerPage()));
                    //     }),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppButtons().kTextBold(
                            title: snapshot.data!.data![1]!.categoryName.toString(),
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            fontColor: AppColors.kBlack),
                        TextButton(
                            onPressed: () {
                              print('see more');
                              print(snapshot.data!.data![1]!.list!.length);
                              Navigator.push(context, MaterialPageRoute(builder: (context) => CategoriesPage(image: snapshot.data!.data![1]!.list,)));
                            },
                            child: const Text(
                              'See more',
                              style: TextStyle(
                                  color: AppColors.kBlack,
                                  decoration: TextDecoration.underline),
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 160,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: 4,
                          itemBuilder: (_, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: (index != 3)
                                  ? GestureDetector(
                                onTap: () {
                                  print('see more1111');
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => InnerPage(image: snapshot.data!.data![1]!.list![index]!.image.toString(),)));
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.8,
                                  height: 130,
                                  decoration: BoxDecoration(
                                    color: Colors.lightBlue,
                                    image: DecorationImage(
                                      image: NetworkImage(snapshot.data!.data![1]!.list![index]!.image.toString()),
                                      fit: BoxFit.cover,
                                    ),
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
                              )
                                  : GestureDetector(
                                onTap: () {
                            print('see more');
                            },
                                child: Container(
                                  width: 200,
                                  height: 200,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
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
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    // crossAxisAlignment: CrossAxisAlignment.center,
                                    children: const [
                                      FaIcon(FontAwesomeIcons.idCard),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'See More',
                                        style: TextStyle(fontSize: 25),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppButtons().kTextBold(
                            title: snapshot.data!.data![2]!.categoryName.toString(),
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            fontColor: AppColors.kBlack),
                        TextButton(
                            onPressed: () {
                              print('see more');
                            },
                            child: const Text(
                              'See more',
                              style: TextStyle(
                                  color: AppColors.kBlack,
                                  decoration: TextDecoration.underline),
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 160,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: 4,
                          itemBuilder: (_, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: (index != 3)
                                  ? GestureDetector(
                                onTap: () {
                                  print('see more1111');
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => InnerPage(image: snapshot.data!.data![2]!.list![index]!.image.toString(),)));
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.8,
                                  height: 130,
                                  decoration: BoxDecoration(
                                    color: Colors.lightBlue,
                                    image: DecorationImage(
                                      image: NetworkImage(snapshot.data!.data![2]!.list![index]!.image.toString()),
                                      fit: BoxFit.cover,
                                    ),
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
                              )
                                  : GestureDetector(
                                onTap: () {
                                  print('see more');
                                },
                                child: Container(
                                  width: 200,
                                  height: 200,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
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
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    // crossAxisAlignment: CrossAxisAlignment.center,
                                    children: const [
                                      FaIcon(FontAwesomeIcons.idCard),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'See More',
                                        style: TextStyle(fontSize: 25),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppButtons().kTextBold(
                            title: snapshot.data!.data![3]!.categoryName.toString(),
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            fontColor: AppColors.kBlack),
                        TextButton(
                            onPressed: () {
                              print('see more');
                            },
                            child: const Text(
                              'See more',
                              style: TextStyle(
                                  color: AppColors.kBlack,
                                  decoration: TextDecoration.underline),
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 160,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: 4,
                          itemBuilder: (_, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: (index != 3)
                                  ? GestureDetector(
                                onTap: () {
                                  print('see more1111');
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => InnerPage(image: snapshot.data!.data![3]!.list![index]!.image.toString(),)));
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.8,
                                  height: 130,
                                  decoration: BoxDecoration(
                                    color: Colors.lightBlue,
                                    image: DecorationImage(
                                      image: NetworkImage(snapshot.data!.data![3]!.list![index]!.image.toString()),
                                      fit: BoxFit.cover,
                                    ),
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
                              )
                                  : GestureDetector(
                                onTap: () {
                                  print('see more');
                                },
                                child: Container(
                                  width: 200,
                                  height: 200,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
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
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    // crossAxisAlignment: CrossAxisAlignment.center,
                                    children: const [
                                      FaIcon(FontAwesomeIcons.idCard),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'See More',
                                        style: TextStyle(fontSize: 25),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppButtons().kTextBold(
                            title: snapshot.data!.data![4]!.categoryName.toString(),
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            fontColor: AppColors.kBlack),
                        TextButton(
                            onPressed: () {
                              print('see more');
                            },
                            child: const Text(
                              'See more',
                              style: TextStyle(
                                  color: AppColors.kBlack,
                                  decoration: TextDecoration.underline),
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 160,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: 4,
                          itemBuilder: (_, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: (index != 3)
                                  ? GestureDetector(
                                onTap: () {
                                  print('see more1111');
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => InnerPage(image: snapshot.data!.data![4]!.list![index]!.image.toString(),)));
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.8,
                                  height: 130,
                                  decoration: BoxDecoration(
                                    color: Colors.lightBlue,
                                    image: DecorationImage(
                                      image: NetworkImage(snapshot.data!.data![4]!.list![index]!.image.toString()),
                                      fit: BoxFit.cover,
                                    ),
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
                              )
                                  : GestureDetector(
                                onTap: () {
                                  print('see more');
                                },
                                child: Container(
                                  width: 200,
                                  height: 200,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
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
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    // crossAxisAlignment: CrossAxisAlignment.center,
                                    children: const [
                                      FaIcon(FontAwesomeIcons.idCard),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'See More',
                                        style: TextStyle(fontSize: 25),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppButtons().kTextBold(
                            title: snapshot.data!.data![5]!.categoryName.toString(),
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            fontColor: AppColors.kBlack),
                        TextButton(
                            onPressed: () {
                              print('see more');
                            },
                            child: const Text(
                              'See more',
                              style: TextStyle(
                                  color: AppColors.kBlack,
                                  decoration: TextDecoration.underline),
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 250,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: 4,
                          itemBuilder: (_, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: (index != 3)
                                  ? GestureDetector(
                                onTap: () {
                                  print('see more1111');
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => InnerPage(image: snapshot.data!.data![5]!.list![index]!.image.toString(),)));
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.4,
                                  height: 130,
                                  decoration: BoxDecoration(
                                    color: Colors.lightBlue,
                                    image: DecorationImage(
                                      image: NetworkImage(snapshot.data!.data![5]!.list![index]!.image.toString()),
                                      fit: BoxFit.cover,
                                    ),
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
                              )
                                  : GestureDetector(
                                onTap: () {
                                  print('see more');
                                },
                                child: Container(
                                  width: 200,
                                  height: 200,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
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
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    // crossAxisAlignment: CrossAxisAlignment.center,
                                    children: const [
                                      FaIcon(FontAwesomeIcons.idCard),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'See More',
                                        style: TextStyle(fontSize: 25),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppButtons().kTextBold(
                            title: snapshot.data!.data![6]!.categoryName.toString(),
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            fontColor: AppColors.kBlack),
                        TextButton(
                            onPressed: () {
                              print('see more');
                            },
                            child: const Text(
                              'See more',
                              style: TextStyle(
                                  color: AppColors.kBlack,
                                  decoration: TextDecoration.underline),
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 160,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: 4,
                          itemBuilder: (_, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: (index != 3)
                                  ? GestureDetector(
                                onTap: () {
                                  print('see more1111');
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => InnerPage(image: snapshot.data!.data![6]!.list![index]!.image.toString(),)));
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.8,
                                  height: 130,
                                  decoration: BoxDecoration(
                                    color: Colors.lightBlue,
                                    image: DecorationImage(
                                      image: NetworkImage(snapshot.data!.data![6]!.list![index]!.image.toString()),
                                      fit: BoxFit.cover,
                                    ),
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
                              )
                                  : GestureDetector(
                                onTap: () {
                                  print('see more');
                                },
                                child: Container(
                                  width: 200,
                                  height: 200,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
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
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    // crossAxisAlignment: CrossAxisAlignment.center,
                                    children: const [
                                      FaIcon(FontAwesomeIcons.idCard),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'See More',
                                        style: TextStyle(fontSize: 25),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppButtons().kTextBold(
                            title: snapshot.data!.data![7]!.categoryName.toString(),
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            fontColor: AppColors.kBlack),
                        TextButton(
                            onPressed: () {
                              print('see more');
                            },
                            child: const Text(
                              'See more',
                              style: TextStyle(
                                  color: AppColors.kBlack,
                                  decoration: TextDecoration.underline),
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 160,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: 4,
                          itemBuilder: (_, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: (index != 3)
                                  ? GestureDetector(
                                onTap: () {
                                  print('see more1111');
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => InnerPage(image: snapshot.data!.data![7]!.list![index]!.image.toString(),)));
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.8,
                                  height: 130,
                                  decoration: BoxDecoration(
                                    color: Colors.lightBlue,
                                    image: DecorationImage(
                                      image: NetworkImage(snapshot.data!.data![7]!.list![index]!.image.toString()),
                                      fit: BoxFit.cover,
                                    ),
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
                              )
                                  : GestureDetector(
                                onTap: () {
                                  print('see more');
                                },
                                child: Container(
                                  width: 200,
                                  height: 200,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
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
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    // crossAxisAlignment: CrossAxisAlignment.center,
                                    children: const [
                                      FaIcon(FontAwesomeIcons.idCard),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'See More',
                                        style: TextStyle(fontSize: 25),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppButtons().kTextBold(
                            title: snapshot.data!.data![8]!.categoryName.toString(),
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            fontColor: AppColors.kBlack),
                        TextButton(
                            onPressed: () {
                              print('see more');
                            },
                            child: const Text(
                              'See more',
                              style: TextStyle(
                                  color: AppColors.kBlack,
                                  decoration: TextDecoration.underline),
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 160,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: 4,
                          itemBuilder: (_, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: (index != 3)
                                  ? GestureDetector(
                                onTap: () {
                                  print('see more1111');
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => InnerPage(image: snapshot.data!.data![8]!.list![index]!.image.toString(),)));
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.8,
                                  height: 130,
                                  decoration: BoxDecoration(
                                    color: Colors.lightBlue,
                                    image: DecorationImage(
                                      image: NetworkImage(snapshot.data!.data![8]!.list![index]!.image.toString()),
                                      fit: BoxFit.cover,
                                    ),
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
                              )
                                  : GestureDetector(
                                onTap: () {
                                  print('see more');
                                },
                                child: Container(
                                  width: 200,
                                  height: 200,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
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
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    // crossAxisAlignment: CrossAxisAlignment.center,
                                    children: const [
                                      FaIcon(FontAwesomeIcons.idCard),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'See More',
                                        style: TextStyle(fontSize: 25),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppButtons().kTextBold(
                            title: snapshot.data!.data![9]!.categoryName.toString(),
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            fontColor: AppColors.kBlack),
                        TextButton(
                            onPressed: () {
                              print('see more');
                            },
                            child: const Text(
                              'See more',
                              style: TextStyle(
                                  color: AppColors.kBlack,
                                  decoration: TextDecoration.underline),
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 160,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: 4,
                          itemBuilder: (_, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: (index != 3)
                                  ? GestureDetector(
                                onTap: () {
                                  print('see more1111');
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => InnerPage(image: snapshot.data!.data![9]!.list![index]!.image.toString(),)));
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.8,
                                  height: 130,
                                  decoration: BoxDecoration(
                                    color: Colors.lightBlue,
                                    image: DecorationImage(
                                      image: NetworkImage(snapshot.data!.data![9]!.list![index]!.image.toString()),
                                      fit: BoxFit.cover,
                                    ),
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
                              )
                                  : GestureDetector(
                                onTap: () {
                                  print('see more');
                                },
                                child: Container(
                                  width: 200,
                                  height: 200,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
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
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    // crossAxisAlignment: CrossAxisAlignment.center,
                                    children: const [
                                      FaIcon(FontAwesomeIcons.idCard),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'See More',
                                        style: TextStyle(fontSize: 25),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppButtons().kTextBold(
                            title: snapshot.data!.data![10]!.categoryName.toString(),
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            fontColor: AppColors.kBlack),
                        TextButton(
                            onPressed: () {
                              print('see more');
                            },
                            child: const Text(
                              'See more',
                              style: TextStyle(
                                  color: AppColors.kBlack,
                                  decoration: TextDecoration.underline),
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 160,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: 4,
                          itemBuilder: (_, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: (index != 3)
                                  ? GestureDetector(
                                onTap: () {
                                  print('see more1111');
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => InnerPage(image: snapshot.data!.data![10]!.list![index]!.image.toString(),)));
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.8,
                                  height: 130,
                                  decoration: BoxDecoration(
                                    color: Colors.lightBlue,
                                    image: DecorationImage(
                                      image: NetworkImage(snapshot.data!.data![10]!.list![index]!.image.toString()),
                                      fit: BoxFit.cover,
                                    ),
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
                              )
                                  : GestureDetector(
                                onTap: () {
                                  print('see more');
                                },
                                child: Container(
                                  width: 200,
                                  height: 200,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
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
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    // crossAxisAlignment: CrossAxisAlignment.center,
                                    children: const [
                                      FaIcon(FontAwesomeIcons.idCard),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'See More',
                                        style: TextStyle(fontSize: 25),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppButtons().kTextBold(
                            title: snapshot.data!.data![11]!.categoryName.toString(),
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            fontColor: AppColors.kBlack),
                        TextButton(
                            onPressed: () {
                              print('see more');
                            },
                            child: const Text(
                              'See more',
                              style: TextStyle(
                                  color: AppColors.kBlack,
                                  decoration: TextDecoration.underline),
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 160,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: 4,
                          itemBuilder: (_, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: (index != 3)
                                  ? GestureDetector(
                                onTap: () {
                                  print('see more1111');
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => InnerPage(image: snapshot.data!.data![11]!.list![index]!.image.toString(),)));
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.8,
                                  height: 130,
                                  decoration: BoxDecoration(
                                    color: Colors.lightBlue,
                                    image: DecorationImage(
                                      image: NetworkImage(snapshot.data!.data![11]!.list![index]!.image.toString()),
                                      fit: BoxFit.cover,
                                    ),
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
                              )
                                  : GestureDetector(
                                onTap: () {
                                  print('see more');
                                },
                                child: Container(
                                  width: 200,
                                  height: 200,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
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
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    // crossAxisAlignment: CrossAxisAlignment.center,
                                    children: const [
                                      FaIcon(FontAwesomeIcons.idCard),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'See More',
                                        style: TextStyle(fontSize: 25),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppButtons().kTextBold(
                            title: snapshot.data!.data![12]!.categoryName.toString(),
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            fontColor: AppColors.kBlack),
                        TextButton(
                            onPressed: () {
                              print('see more');
                            },
                            child: const Text(
                              'See more',
                              style: TextStyle(
                                  color: AppColors.kBlack,
                                  decoration: TextDecoration.underline),
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 160,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: 4,
                          itemBuilder: (_, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: (index != 3)
                                  ? GestureDetector(
                                onTap: () {
                                  print('see more1111');
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => InnerPage(image: snapshot.data!.data![12]!.list![index]!.image.toString(),)));
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.8,
                                  height: 130,
                                  decoration: BoxDecoration(
                                    color: Colors.lightBlue,
                                    image: DecorationImage(
                                      image: NetworkImage(snapshot.data!.data![12]!.list![index]!.image.toString()),
                                      fit: BoxFit.cover,
                                    ),
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
                              )
                                  : GestureDetector(
                                onTap: () {
                                  print('see more');
                                },
                                child: Container(
                                  width: 200,
                                  height: 200,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
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
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    // crossAxisAlignment: CrossAxisAlignment.center,
                                    children: const [
                                      FaIcon(FontAwesomeIcons.idCard),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'See More',
                                        style: TextStyle(fontSize: 25),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppButtons().kTextBold(
                            title: snapshot.data!.data![13]!.categoryName.toString(),
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            fontColor: AppColors.kBlack),
                        TextButton(
                            onPressed: () {
                              print('see more');
                            },
                            child: const Text(
                              'See more',
                              style: TextStyle(
                                  color: AppColors.kBlack,
                                  decoration: TextDecoration.underline),
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 160,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: 4,
                          itemBuilder: (_, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: (index != 3)
                                  ? GestureDetector(
                                onTap: () {
                                  print('see more1111');
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => InnerPage(image: snapshot.data!.data![13]!.list![index]!.image.toString(),)));
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.8,
                                  height: 130,
                                  decoration: BoxDecoration(
                                    color: Colors.lightBlue,
                                    image: DecorationImage(
                                      image: NetworkImage(snapshot.data!.data![13]!.list![index]!.image.toString()),
                                      fit: BoxFit.cover,
                                    ),
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
                              )
                                  : GestureDetector(
                                onTap: () {
                                  print('see more');
                                },
                                child: Container(
                                  width: 200,
                                  height: 200,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
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
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    // crossAxisAlignment: CrossAxisAlignment.center,
                                    children: const [
                                      FaIcon(FontAwesomeIcons.idCard),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'See More',
                                        style: TextStyle(fontSize: 25),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppButtons().kTextBold(
                            title: snapshot.data!.data![14]!.categoryName.toString(),
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            fontColor: AppColors.kBlack),
                        TextButton(
                            onPressed: () {
                              print('see more');
                            },
                            child: const Text(
                              'See more',
                              style: TextStyle(
                                  color: AppColors.kBlack,
                                  decoration: TextDecoration.underline),
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 160,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: 4,
                          itemBuilder: (_, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: (index != 3)
                                  ? GestureDetector(
                                onTap: () {
                                  print('see more1111');
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => InnerPage(image: snapshot.data!.data![14]!.list![index]!.image.toString(),)));
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.8,
                                  height: 130,
                                  decoration: BoxDecoration(
                                    color: Colors.lightBlue,
                                    image: DecorationImage(
                                      image: NetworkImage(snapshot.data!.data![14]!.list![index]!.image.toString()),
                                      fit: BoxFit.cover,
                                    ),
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
                              )
                                  : GestureDetector(
                                onTap: () {
                                  print('see more');
                                },
                                child: Container(
                                  width: 200,
                                  height: 200,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
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
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    // crossAxisAlignment: CrossAxisAlignment.center,
                                    children: const [
                                      FaIcon(FontAwesomeIcons.idCard),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'See More',
                                        style: TextStyle(fontSize: 25),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                    // AppButtons().kHomeCategory(
                    //     title: AppStrings.kArtDesign,
                    //     context: context,
                    //     // image: snapshot.data!.data![1]!.list,
                    //     onTap: () {
                    //       print('see more');
                    //     },
                    //     onTap1: () {
                    //       print(AppStrings.kArtDesign);
                    //     }),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
