// ignore_for_file: unnecessary_new

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:visiting_card/common/AppStrings.dart';
import 'package:visiting_card/screens/app_store.dart';
import 'package:transparent_image/transparent_image.dart';

class CreateYourOwnPage extends StatefulWidget {
  const CreateYourOwnPage({Key? key}) : super(key: key);

  @override
  State<CreateYourOwnPage> createState() => _CreateYourOwnPageState();
}

class _CreateYourOwnPageState extends State<CreateYourOwnPage> {
  List<String> imageList = [
    'https://pixabay.com/get/55e6d7414f53a514f1dc8460da293276103cdded5b5871_640.jpg',
    'https://pixabay.com/get/54e1d1454b5aad14f1dc8460da293276103cdde25b5871_640.jpg',
    'https://pixabay.com/get/57e8d7414e5aa814f1dc8460da293276103cdded5b5673_640.jpg',
    'https://pixabay.com/get/57e9d0434e52ae14f1dc8460da293276103cdded5b5470_640.jpg',
    'https://pixabay.com/get/54e9d3454f54a514f1dc8460da293276103cdded535678_640.jpg',
    'https://pixabay.com/get/5fe1dd464354b10ff3d89960c62d3f7b163cd6ed5158_640.jpg',
    'https://pixabay.com/get/57e5d3414a50a914f1dc8460da293276103cdded5b5078_640.jpg'
  ];
  List<Widget> example = [
    Container(
      decoration: BoxDecoration(
          color: Colors.pink,
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        // child: FadeInImage.memoryNetwork(
        //   placeholder: kTransparentImage, image: imageList[index],fit: BoxFit.cover,),
        child: Text('index: 0'),
      ),
    ),
    Container(
      decoration: BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        // child: FadeInImage.memoryNetwork(
        //   placeholder: kTransparentImage, image: imageList[index],fit: BoxFit.cover,),
        child: Text('index: 0'),
      ),
    ),
    Container(
      decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        // child: FadeInImage.memoryNetwork(
        //   placeholder: kTransparentImage, image: imageList[index],fit: BoxFit.cover,),
        child: Text('index: 0'),
      ),
    ),
    Container(
      decoration: BoxDecoration(
          color: Colors.yellow,
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        // child: FadeInImage.memoryNetwork(
        //   placeholder: kTransparentImage, image: imageList[index],fit: BoxFit.cover,),
        child: Text('index: 0'),
      ),
    ),
    Container(
      decoration: BoxDecoration(
          color: Colors.pink,
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        // child: FadeInImage.memoryNetwork(
        //   placeholder: kTransparentImage, image: imageList[index],fit: BoxFit.cover,),
        child: Text('index: 0'),
      ),
    ),
    Container(
      decoration: BoxDecoration(
          color: Colors.pink,
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        // child: FadeInImage.memoryNetwork(
        //   placeholder: kTransparentImage, image: imageList[index],fit: BoxFit.cover,),
        child: Text('index: 0'),
      ),
    ),
  ];

  List<StaggeredTile> _staggeredTiles = const <StaggeredTile>[
    const StaggeredTile.count(2, 2),
    const StaggeredTile.count(2, 2.4),
    const StaggeredTile.count(2, 1.3),
    const StaggeredTile.count(2, 2.8),
    const StaggeredTile.count(2, 2),
    const StaggeredTile.count(2, 2.3),
    const StaggeredTile.count(2, 3),
    const StaggeredTile.count(2, 3.5),
    const StaggeredTile.count(2, 1),
    const StaggeredTile.count(2, 1.2),
    const StaggeredTile.count(2, 2),
    const StaggeredTile.count(2, 2.4),
    const StaggeredTile.count(2, 1.3),
    const StaggeredTile.count(2, 2.8),
    const StaggeredTile.count(2, 2),
    const StaggeredTile.count(2, 2.3),
    const StaggeredTile.count(2, 3),
    const StaggeredTile.count(2, 3.5),
    const StaggeredTile.count(2, 1),
    const StaggeredTile.count(2, 1.2),
    const StaggeredTile.count(2, 3.5),
    const StaggeredTile.count(2, 1),
    const StaggeredTile.count(2, 1.2),
  ];
  List<Widget> _tiles = const <Widget>[
    const _Example01Tile(Colors.green, 'Custom Size'),
    const _Example01Tile(Colors.lightBlue, 'Standard Portrait'),
    const _Example01Tile(Colors.amber, 'Standard Landscape'),
    const _Example01Tile(Colors.brown, 'Instagram Portrait'),
    const _Example01Tile(Colors.deepOrange, 'Instagram Square'),
    const _Example01Tile(Colors.indigo, 'Pinterest Post'),
    const _Example01Tile(Colors.red, 'Instagram Story'),
    const _Example01Tile(Colors.pink, 'Snapchat Geofilter'),
    const _Example01Tile(Colors.purple, 'Cover 3:1'),
    const _Example01Tile(Colors.blue, 'Twitter Post'),
    const _Example01Tile(Colors.green, 'Custom Size'),
    const _Example01Tile(Colors.lightBlue, 'Standard Portrait'),
    const _Example01Tile(Colors.amber, 'Standard Landscape'),
    const _Example01Tile(Colors.brown, 'Instagram Portrait'),
    const _Example01Tile(Colors.deepOrange, 'Instagram Square'),
    const _Example01Tile(Colors.indigo, 'Pinterest Post'),
    const _Example01Tile(Colors.red, 'Instagram Story'),
    const _Example01Tile(Colors.pink, 'Snapchat Geofilter'),
    const _Example01Tile(Colors.purple, 'Cover 3:1'),
    const _Example01Tile(Colors.blue, 'Twitter Post'),
    const _Example01Tile(Colors.pink, 'Snapchat Geofilter'),
    const _Example01Tile(Colors.purple, 'Cover 3:1'),
    const _Example01Tile(Colors.blue, 'Twitter Post'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: const Text(AppStrings.kWhatYouNeed),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: GestureDetector(
                onTap: () {
                  print('Ads');
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AppsStorePage()));
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
        // body: Container(
        //   margin: const EdgeInsets.all(20),
        //   child: StaggeredGrid.count(
        //     crossAxisCount: 4,
        //     mainAxisSpacing: 4,
        //     crossAxisSpacing: 4,
        //     children: const [
        //       StaggeredGridTile.count(
        //         crossAxisCellCount: 2,
        //         mainAxisCellCount: 2,
        //         child: Text('index: 0'),
        //       ),
        //       StaggeredGridTile.count(
        //         crossAxisCellCount: 2,
        //         mainAxisCellCount: 1,
        //         child: Text('index: 1'),
        //       ),
        //       StaggeredGridTile.count(
        //         crossAxisCellCount: 1,
        //         mainAxisCellCount: 1,
        //         child: Text('index: 2'),
        //       ),
        //       StaggeredGridTile.count(
        //         crossAxisCellCount: 1,
        //         mainAxisCellCount: 1,
        //         child: Text('index: 3'),
        //       ),
        //       StaggeredGridTile.count(
        //         crossAxisCellCount: 4,
        //         mainAxisCellCount: 2,
        //         child: Text('index: 4'),
        //       ),
        //     ],
        //   ),
        // ),
        // body: Container(
        //   margin: EdgeInsets.all(12),
        //   child: StaggeredGridView.countBuilder(
        //       crossAxisCount: 2,
        //       crossAxisSpacing: 12,
        //       mainAxisSpacing: 12,
        //       itemCount: 10,
        //       itemBuilder: (context, index) {
        //         return Container(
        //           decoration: BoxDecoration(
        //               color: Colors.pink,
        //               borderRadius: BorderRadius.all(Radius.circular(12))),
        //           child: ClipRRect(
        //             borderRadius: BorderRadius.all(Radius.circular(12)),
        //             // child: FadeInImage.memoryNetwork(
        //             //   placeholder: kTransparentImage, image: imageList[index],fit: BoxFit.cover,),
        //             child: Text('index: $index'),
        //           ),
        //         );
        //       },
        //       staggeredTileBuilder: (index) {
        //         return new StaggeredTile.count(1,  1.8);
        //       }),
        // ),
        body: new Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: new StaggeredGridView.count(
              crossAxisCount: 4,
              staggeredTiles: _staggeredTiles,
              children: _tiles,
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0,
              padding: const EdgeInsets.all(4.0),
            ))
        // body: Container(margin: const EdgeInsets.all(20),
        //     child: StaggeredGridView.count(crossAxisCount: 4,
        //   mainAxisSpacing: 4,
        //   crossAxisSpacing: 4,
        //   children: [
        //     StaggeredGridTile.count(
        //       crossAxisCellCount: 2,
        //       mainAxisCellCount: 2,
        //       child: Text('index: 0'),
        //     ),
        //     StaggeredGridTile.count(
        //       crossAxisCellCount: 2,
        //       mainAxisCellCount: 1,
        //       child: Text('index: 1'),
        //     ),
        //     StaggeredGridTile.count(
        //       crossAxisCellCount: 1,
        //       mainAxisCellCount: 1,
        //       child: Text('index: 2'),
        //     ),
        //     StaggeredGridTile.count(
        //       crossAxisCellCount: 1,
        //       mainAxisCellCount: 1,
        //       child: Text('index: 3'),
        //     ),
        //     StaggeredGridTile.count(
        //       crossAxisCellCount: 4,
        //       mainAxisCellCount: 2,
        //       child: Text('index: 4'),
        //     ),
        //   ],)),
        );
  }
}

class _Example01Tile extends StatelessWidget {
  const _Example01Tile(this.backgroundColor, this.title);

  final Color backgroundColor;
  final String title;

  @override
  Widget build(BuildContext context) {
    return new Card(
      color: backgroundColor,
      child: new InkWell(
        onTap: () {
          print('object');
        },
        child: new Center(
          child: new Padding(
            padding: const EdgeInsets.all(4.0),
            child: new Text(title),
          ),
        ),
      ),
    );
  }
}
