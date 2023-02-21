import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:visiting_card/common/AppButtons.dart';
import 'package:visiting_card/common/AppColors.dart';
import 'package:visiting_card/common/AppStrings.dart';
import 'package:visiting_card/models/demo_model.dart';

class AppsStorePage extends StatefulWidget {
  const AppsStorePage({Key? key}) : super(key: key);

  @override
  State<AppsStorePage> createState() => _AppsStorePageState();
}

class _AppsStorePageState extends State<AppsStorePage> {

  @override
  void initState(){
    super.initState();
    appsStore();
  }

  Future<List<AutoGenerate>?> appsStore() async {
    print('appsStore');
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
        centerTitle: true,
        title: AppButtons().kTextNormal(title: AppStrings.kAppsStore, fontSize: 20, fontWeight: FontWeight.bold, fontColor: AppColors.kWhite),
        leading: IconButton(
          icon: const FaIcon(FontAwesomeIcons.circleArrowLeft,size: 30,),
          color: AppColors.koffWhite,
          onPressed: () {
            print('settings clicked');
            Navigator.pop(context);
            // Navigator.push(context, MaterialPageRoute(builder: (context)=> const HomePage()));
          },
        ),
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.symmetric(horizontal: 8.0),
        //     child: Image.asset(
        //       'assets/images/Web_Advertising.png',
        //       width: 25,
        //       height: 25,
        //     ),
        //   )
        // ],
      ),
      body: ListView.builder(
          itemCount: 10,
          itemBuilder: (BuildContext context,int index){
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 15),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 130,
                decoration: const BoxDecoration(
                    color: AppColors.koffWhite,
                    // gradient: LinearGradient(
                    //   begin: Alignment.topRight,
                    //   end: Alignment.bottomLeft,
                    //   colors: <Color>[
                    //     AppColors.kLightGreen,
                    //     const Color(0xFFA8E4E4)
                    //   ],
                    // ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          blurRadius: 5.0,
                          offset: Offset(0, 3)),
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(30))
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10,right: 10,top: 20,bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: const BoxDecoration(
                            color: AppColors.kLightGrey,
                            borderRadius: BorderRadius.all(Radius.circular(20))
                        ),
                      ),
                      const SizedBox(width: 10,),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            const SizedBox(height: 20,),
                            AppButtons().kTextNormal(title: 'Application Name', fontSize: 15, fontWeight: FontWeight.w400, fontColor: AppColors.kBlack),
                            const SizedBox(height: 10,),
                            AppButtons().kTextNormal(title: 'Make your own flyer with templates.', fontSize: 13, fontWeight: FontWeight.w400, fontColor: AppColors.kDarkGrey)
                          ],
                        ),
                      ),
                      const SizedBox(width: 10,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.kBlack,
                                elevation: 2,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10))),
                              ),
                              onPressed: () {
                                print('submit');
                              },
                              child: const SizedBox(
                                width: 50,
                                height: 30,
                                child: Center(
                                  child: Text(
                                    'INSTALL',
                                    style: TextStyle(
                                        color: AppColors.kWhite,
                                        fontFamily: 'Inter-Regular',
                                        fontWeight: FontWeight.normal,
                                        fontSize: 12),
                                  ),
                                ),
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
      ),
    );
  }
}
