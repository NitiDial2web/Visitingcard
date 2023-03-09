import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visiting_card/common/AppButtons.dart';
import 'package:visiting_card/common/AppColors.dart';
import 'package:visiting_card/common/AppStrings.dart';
import 'package:visiting_card/models/demo_model.dart';
import 'package:visiting_card/models/tutorial_video.dart';
import 'package:visiting_card/screens/app_store.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TutorialVideoPage extends StatefulWidget {
  const TutorialVideoPage({Key? key}) : super(key: key);

  @override
  State<TutorialVideoPage> createState() => _TutorialVideoPageState();
}

class _TutorialVideoPageState extends State<TutorialVideoPage> {
  List<String> _videos = [];

  @override
  void initState(){
    super.initState();
    // tutorial();
  }

  Future<GetVideoModel?> tutorial() async {
    // preferences = await SharedPreferences.getInstance();
    try {
      final response = await http.get(
        Uri.parse(AppStrings.kGetVideoUrl),
        // body: {"users_id": preferences.getString(AppStrings.kPrefUserIdKey)}
      );

      var responseData = jsonDecode(response.body);
      print('response apps  $responseData');
      print('response.statusCode:${response.statusCode}');
      if (response.statusCode == 200) {
        if (responseData['success'] == 1) {
          var _usersData = responseData['data'];
          for (int i = 0; i < _usersData.length; i++) {
            _videos.add(_usersData[i]['video']);
          }
          print('_videos :$_videos');
          return GetVideoModel.fromJson(responseData);
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

  Future<void> _launchYoutubeVideo(String _youtubeUrl) async {
    if (_youtubeUrl != null && _youtubeUrl.isNotEmpty) {
      if (await canLaunch(_youtubeUrl)) {
        final bool _nativeAppLaunchSucceeded = await launch(
          _youtubeUrl,
          forceSafariVC: false,
          universalLinksOnly: true,
        );
        if (!_nativeAppLaunchSucceeded) {
          await launch(_youtubeUrl, forceSafariVC: true);
        }
      }
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
      body: FutureBuilder<GetVideoModel?>(
          future: tutorial(),
          builder: (BuildContext context,AsyncSnapshot<GetVideoModel?> snapshot) {
            // print('niti1111:${snapshot.data!.data.first.video}');
            // print('snapshot.connectionState:${snapshot.connectionState}');
            // if(snapshot.connectionState == ConnectionState.done){
            if (!snapshot.hasData) {
              print('if condition');
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            else {
              print('else condition');

              return ListView.builder(
                itemCount: snapshot.data!.data.length,
                itemBuilder: (BuildContext context, index) {
                  var videoIdd = YoutubePlayer.convertUrlToId("${snapshot.data!.data[index].video}");
                  print('this is +$videoIdd');
                  final YoutubePlayerController _controller = YoutubePlayerController(
                    // initialVideoId: snapshot.data!.data[index].video,
                    initialVideoId: 'iLnmTe5Q2Qw',
                    flags: const YoutubePlayerFlags(
                      autoPlay: true,
                      mute: false,
                    ),
                  );
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 30),
                    child: GestureDetector(
                      onTap: (){
                        print('video:${snapshot.data!.data[index].video}');
                        _launchYoutubeVideo(snapshot.data!.data[index].video);
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 170,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                    snapshot.data!.data[index].video),
                                fit: BoxFit.fill),
                            color: AppColors.kGrey,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 5.0,
                                  offset: Offset(0, 3)),
                            ],
                            borderRadius:
                            BorderRadius.all(Radius.circular(30))),
                        // child: Text(snapshot.data!.data[index].video),
                        child: YoutubePlayer(
                          controller: _controller,
                          liveUIColor: Colors.amber,
                        ),
                      ),
                    ),
                  );
                },
              );
            }
            // }
            // else{
            //   return Center(
            //     child: CircularProgressIndicator(color: Colors.red,),
            //   );
            // }
          }),
    );
  }
}
