import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:visiting_card/common/AppColors.dart';

class AppButtons {
  Widget kElevatedButton({required String title}) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.kLightPink,
          elevation: 2,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30))),
        ),
        onPressed: () {
          print('submit');
        },
        child: SizedBox(
          width: 200,
          height: 50,
          // decoration: const BoxDecoration(
          //     color: AppColors.kLightGreen,
          //     borderRadius: BorderRadius.all(Radius.circular(30))),
          child: Center(
            child: Text(
              title,
              style: const TextStyle(
                  color: AppColors.kWhite,
                  fontFamily: 'Inter-Regular',
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
            ),
          ),
        ));
  }

  Widget kHomeCategory({
    required String title,
    required BuildContext context,
    required Function() onTap1,
    required Function() onTap,
    // String? image,
    // int length = 4,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppButtons().kTextBold(
                title: title,
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
                          onTap: onTap1,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: 130,
                            decoration: BoxDecoration(
                              color: Colors.lightBlue,
                              // image: DecorationImage(
                              //   image: NetworkImage(image!),
                              //   fit: BoxFit.fill,
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
                        )
                      : GestureDetector(
                          onTap: onTap,
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
      ],
    );
  }

  Widget kTextNormal(
      {required String title,
      required double fontSize,
      required FontWeight fontWeight,
      required Color fontColor}) {
    return Text(
      title,
      style: TextStyle(
          color: fontColor,
          fontSize: fontSize,
          fontWeight: fontWeight,
          fontFamily: 'Inter-Regular'),
    );
  }

  Widget kTextBold(
      {required String title,
      required double fontSize,
      required FontWeight fontWeight,
      required Color fontColor}) {
    return Text(
      title,
      style: TextStyle(
          color: fontColor,
          fontSize: fontSize,
          fontWeight: fontWeight,
          fontFamily: 'Inter-Bold'),
    );
  }
}
