import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:visiting_card/common/AppButtons.dart';
import 'package:visiting_card/common/AppColors.dart';
import 'package:visiting_card/common/AppStrings.dart';
import 'package:visiting_card/screens/app_store.dart';

class MoreAppsPage extends StatefulWidget {
  const MoreAppsPage({Key? key}) : super(key: key);

  @override
  State<MoreAppsPage> createState() => _MoreAppsPageState();
}

class _MoreAppsPageState extends State<MoreAppsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.kAppBarColor,
        // centerTitle: true,
        title: AppButtons().kTextNormal(title: AppStrings.kMoreApp, fontSize: 20, fontWeight: FontWeight.bold, fontColor: AppColors.kWhite),
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
        // child: FaIcon(FontAwesomeIcons.googlePlay,size: 200,),
        child: Image.asset('assets/images/google-play.png',width: 250,height: 250,),
      ),
    );
  }
}
