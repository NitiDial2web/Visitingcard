import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:visiting_card/common/AppButtons.dart';
import 'package:visiting_card/common/AppColors.dart';
import 'package:visiting_card/common/AppStrings.dart';
import 'package:visiting_card/screens/app_store.dart';
import 'package:visiting_card/screens/inner_page.dart';

class NewHomePage extends StatefulWidget {
  const NewHomePage({Key? key}) : super(key: key);

  @override
  State<NewHomePage> createState() => _NewHomePageState();
}

class _NewHomePageState extends State<NewHomePage> {
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppButtons().kHomeCategory(title: AppStrings.kMyDesign, context: context,onTap: (){
                print('see more');
              },onTap1: (){
                print(AppStrings.kMyDesign);
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const InnerPage()));
              }),
              AppButtons().kHomeCategory(title: AppStrings.kArtDesign, context: context,onTap: (){
                print('see more');
              },onTap1: (){
                print(AppStrings.kArtDesign);
              }),
              AppButtons().kHomeCategory(title: AppStrings.kLandscapes, context: context,onTap: (){
                print('see more');
              },onTap1: (){
                print(AppStrings.kLandscapes);
              }),
              AppButtons().kHomeCategory(title: AppStrings.kDesignerChoice, context: context,onTap: (){
                print('see more');
              },onTap1: (){
                print(AppStrings.kDesignerChoice);
              }),
              AppButtons().kHomeCategory(title: AppStrings.kModern, context: context,onTap: (){
                print('see more');
              },onTap1: (){
                print(AppStrings.kModern);
              }),
              AppButtons().kTextBold(
                  title: AppStrings.kPortrait,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  fontColor: AppColors.kBlack),
              SizedBox(
                height: 250,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    itemBuilder: (_, index) {
                      return (index !=3)
                      ?GestureDetector(
                        onTap: (){
                          print('object');
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: 200,
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
                      :GestureDetector(
                        onTap: (){
                          print('object111');
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.4,
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
                                SizedBox(height: 10,),
                                Text('See More',
                                  style: TextStyle(
                                      fontSize: 25
                                  ),)
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
              // AppButtons().kHomeCategory(title: AppStrings.kPortrait, context: context),
              AppButtons().kHomeCategory(title: AppStrings.kNameTitle, context: context,onTap: (){
                print('see more');
              },onTap1: (){
                print(AppStrings.kNameTitle);
              }),
              AppButtons().kHomeCategory(title: AppStrings.kPhotos,context: context,onTap: (){
                print('see more');
              },onTap1: (){
                print(AppStrings.kPhotos);
              }),
              AppButtons().kHomeCategory(title: AppStrings.kGlossy, context: context,onTap: (){
                print('see more');
              },onTap1: (){
                print(AppStrings.kGlossy);
              }),
              AppButtons().kHomeCategory(title: AppStrings.kSimple, context: context,onTap: (){
                print('see more');
              },onTap1: (){
                print(AppStrings.kSimple);
              }),
              AppButtons().kHomeCategory(title: AppStrings.kShop, context: context,onTap: (){
                print('see more');
              },onTap1: (){
                print(AppStrings.kShop);
              }),
              AppButtons().kHomeCategory(title: AppStrings.kEntertainment, context: context,onTap: (){
                print('see more');
              },onTap1: (){
                print(AppStrings.kEntertainment);
              }),
              AppButtons().kHomeCategory(title: AppStrings.kBusiness, context: context,onTap: (){
                print('see more');
              },onTap1: (){
                print(AppStrings.kBusiness);
              }),
              AppButtons().kHomeCategory(title: AppStrings.kSpecialCards, context: context,onTap: (){
                print('see more');
              },onTap1: (){
                print(AppStrings.kSpecialCards);
              }),
            ],
          ),
        ),
      ),
    );
  }
}
