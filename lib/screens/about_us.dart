import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:visiting_card/common/AppButtons.dart';
import 'package:visiting_card/common/AppColors.dart';
import 'package:visiting_card/common/AppStrings.dart';
import 'package:visiting_card/models/about_us.dart';
import 'package:visiting_card/models/demo_model.dart';
import 'package:visiting_card/screens/app_store.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  String email = '';

  @override
  void initState(){
    super.initState();
    aboutUs();
  }

  Future<GetAboutUsModel?> aboutUs() async {
    // preferences = await SharedPreferences.getInstance();
    try {
      final response = await http.get(Uri.parse(AppStrings.kGetAboutUsUrl),
        // body: {"users_id": preferences.getString(AppStrings.kPrefUserIdKey)}
      );

      var responseData = jsonDecode(response.body);
      print('response images  $responseData');
      print('response.statusCode:${response.statusCode}');
      if (response.statusCode == 200) {
        if (responseData['success'] == 1) {
          var _usersData = responseData['data'];
          setState(() {
            email = _usersData[0]['description'];
          });
          print(email);
          return GetAboutUsModel.fromJson(responseData);
        } else {
          // AppCommon.showToast(responseData["message"]);
        }
      } else {
        throw Exception('Failed to load data');
      }
    } catch (exception) {
      print('exception getHomeImages $exception');
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.kAppBarColor,
        // centerTitle: true,
        title: AppButtons().kTextNormal(title: AppStrings.kAbout, fontSize: 20, fontWeight: FontWeight.bold, fontColor: AppColors.kWhite),
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              const CircleAvatar(
                radius: 100,
                backgroundImage: AssetImage('assets/images/Web_Advertising.png'),
              ),
              const SizedBox(
                height: 20,
              ),
              AppButtons().kTextNormal(
                  title: 'Email: $email',
                  fontSize: 25,
                  fontWeight: FontWeight.w400,
                  fontColor: AppColors.kBlack),
              AppButtons().kTextNormal(
                  title: AppStrings.kReserved,
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  fontColor: AppColors.kBlack)
            ],
          ),
        ),
      ),
    );
  }
}
