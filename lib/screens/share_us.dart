import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:visiting_card/common/AppButtons.dart';
import 'package:visiting_card/common/AppColors.dart';
import 'package:visiting_card/common/AppStrings.dart';
import 'package:visiting_card/screens/app_store.dart';

class ShareUsPage extends StatefulWidget {
  const ShareUsPage({Key? key}) : super(key: key);

  @override
  State<ShareUsPage> createState() => _ShareUsPageState();
}

class _ShareUsPageState extends State<ShareUsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.kAppBarColor,
        // centerTitle: true,
        title: AppButtons().kTextNormal(title: AppStrings.kShare, fontSize: 20, fontWeight: FontWeight.bold, fontColor: AppColors.kWhite),
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
        padding: const EdgeInsets.only(top: 150),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 330,
              height: 200,
              decoration: const BoxDecoration(
                color: AppColors.kGrey,
                  // gradient: LinearGradient(
                  //   begin: Alignment.topLeft,
                  //   end: Alignment.bottomRight,
                  //   colors: <Color>[AppColors.kLightGreen, AppColors.kWhite],
                  // ),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey,
                        blurRadius: 5.0,
                        offset: Offset(0, 3)),
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset('assets/images/whatsapp.png',width: 50,height: 50,),
                        Image.asset('assets/images/gmail.png',width: 50,height: 50,),
                        Image.asset('assets/images/facebook.png',width: 50,height: 50,),
                        Image.asset('assets/images/instagram.png',width: 50,height: 50,),
                        // FaIcon(FontAwesomeIcons.whatsapp,size: 40,),
                        // FaIcon(FontAwesomeIcons.envelope,size: 40,),
                        // FaIcon(FontAwesomeIcons.facebook,size: 40,),
                        // FaIcon(FontAwesomeIcons.instagram,size: 40,),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset('assets/images/linkedin.png',width: 50,height: 50,),
                        Image.asset('assets/images/youtube1.png',width: 50,height: 50,),
                        Image.asset('assets/images/twitter.png',width: 50,height: 50,),
                        Image.asset('assets/images/tik-tok1.png',width: 50,height: 50,),
                        // FaIcon(FontAwesomeIcons.linkedin,size: 40,),
                        // FaIcon(FontAwesomeIcons.youtube,size: 40,),
                        // FaIcon(FontAwesomeIcons.twitter,size: 40,),
                        // FaIcon(FontAwesomeIcons.tiktok,size: 40,),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
