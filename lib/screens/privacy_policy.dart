import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:visiting_card/common/AppButtons.dart';
import 'package:visiting_card/common/AppColors.dart';
import 'package:visiting_card/common/AppStrings.dart';
import 'package:visiting_card/models/demo_model.dart';
import 'package:visiting_card/screens/app_store.dart';

class PrivacyPolicyPage extends StatefulWidget {
  const PrivacyPolicyPage({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicyPage> createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {

  @override
  void initState(){
    super.initState();
    privacyPolicy();
  }

  Future<List<AutoGenerate>?> privacyPolicy() async {
    print('privacyPolicy');
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
        title: AppButtons().kTextNormal(
            title: AppStrings.kPrivacy,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontColor: AppColors.kWhite),
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Column(
          children: [
            AppButtons().kTextBold(
                title: AppStrings.kPrivacy,
                fontSize: 35,
                fontWeight: FontWeight.bold,
                fontColor: AppColors.kBlack),
            const SizedBox(
              height: 15,
            ),
            AppButtons().kTextNormal(
                title:
                'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                fontSize: 20,
                fontWeight: FontWeight.normal,
                fontColor: AppColors.kBlack)
          ],
        ),
      ),
    );
  }
}
