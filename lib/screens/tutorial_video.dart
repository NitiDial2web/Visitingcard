import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:visiting_card/common/AppButtons.dart';
import 'package:visiting_card/common/AppColors.dart';
import 'package:visiting_card/common/AppStrings.dart';
import 'package:visiting_card/models/demo_model.dart';
import 'package:visiting_card/screens/app_store.dart';

class TutorialVideoPage extends StatefulWidget {
  const TutorialVideoPage({Key? key}) : super(key: key);

  @override
  State<TutorialVideoPage> createState() => _TutorialVideoPageState();
}

class _TutorialVideoPageState extends State<TutorialVideoPage> {

  @override
  void initState(){
    super.initState();
    tutorial();
  }

  Future<List<AutoGenerate>?> tutorial() async {
    print('tutorial');
    try {
      // var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.usersEndpoint);
      var response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));
      var data = json.decode(response.body);
      print('DATA11: $data');
      print('response.statusCode${response.statusCode}');
      if (response.statusCode == 200) {
        print('DATA: $data');
        // List<AutoGenerate> _model = userModelFromJson(response.body);
        // return _model;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.kAppBarColor,
        // centerTitle: true,
        title: AppButtons().kTextNormal(title: AppStrings.kTutorial, fontSize: 20, fontWeight: FontWeight.bold, fontColor: AppColors.kWhite),
        leading: IconButton(
          icon: const Icon(Icons.settings, size: 25),
          color: AppColors.koffWhite,
          onPressed: () {
            print('settings clicked');
            // Navigator.push(context, MaterialPageRoute(builder: (context)=> const HomePage()));
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
          )
        ],
      ),
      body: ListView.builder(
          itemCount: 10,
          itemBuilder: (BuildContext context,int index){
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 30),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 170,
                decoration: const BoxDecoration(
                    color: AppColors.kLightGrey,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          blurRadius: 5.0,
                          offset: Offset(0, 3)),
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(30))
                ),
                // child: Text(item.toString()),
              ),
            );
          }
      ),
    );
  }
}
