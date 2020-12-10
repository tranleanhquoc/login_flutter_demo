import 'package:carousel_slider/carousel_slider.dart';
import 'package:example/commons/app_assets.dart';
import 'package:example/components/square_button.dart';
import 'package:example/data/models/carousel_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<CarouselModel> _carousels = [
    CarouselModel(
        imageUrl: AssetsPNG.carousel1,
        avatarUrl: AssetsPNG.member2,
        name: "Ridhwan Nordin",
        nickname: "@ridzjcob"),
    CarouselModel(
        imageUrl: AssetsPNG.carousel2,
        avatarUrl: AssetsPNG.member3,
        name: "Clem Onojeghuo",
        nickname: "@clemono2"),
    CarouselModel(
        imageUrl: AssetsPNG.carousel3,
        avatarUrl: AssetsPNG.member4,
        name: "Jon Tyson",
        nickname: "@jontyson"),
    CarouselModel(
        imageUrl: AssetsPNG.carousel4,
        avatarUrl: AssetsPNG.member5,
        name: "Simon Zhu",
        nickname: "@smnzhu"),
  ];

  List<String> _gridImgs = [
    AssetsPNG.gridview1,
    AssetsPNG.gridview2,
    AssetsPNG.gridview3,
    AssetsPNG.gridview4,
    AssetsPNG.gridview5,
    AssetsPNG.gridview6,
    AssetsPNG.gridview7,
    AssetsPNG.gridview8,
    AssetsPNG.gridview9,
    AssetsPNG.gridview10,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
                child: Container(
                    padding: EdgeInsets.fromLTRB(16, 32, 16, 0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Discover",
                            style: GoogleFonts.comfortaa(fontSize: 36),
                          ),
                          SizedBox(height: 32),
                          Text("WHAT'S NEW TODAY",
                              style: GoogleFonts.roboto(
                                  fontSize: 13, fontWeight: FontWeight.w900)),
                          SizedBox(height: 24),
                          CarouselSlider(
                            options: CarouselOptions(
                                height: MediaQuery.of(context).size.width + 12,
                                viewportFraction: 1),
                            items: _carousels
                                .map((item) => _buildCarouselSlider(item))
                                .toList(),
                          ),
                          SizedBox(height: 48),
                          Text("BROWSE ALL",
                              style: GoogleFonts.roboto(
                                  fontSize: 13, fontWeight: FontWeight.w900)),
                          SizedBox(height: 24),
                          _buildImageGridView(),
                          SquareButton(
                            margin: EdgeInsets.symmetric(vertical: 32),
                            onTap: () {},
                            text: "SEE MORE",
                            textStyle: GoogleFonts.roboto(
                                fontSize: 13, fontWeight: FontWeight.w900),
                            boxBorder:
                                Border.all(color: Colors.black, width: 2),
                          )
                        ])))));
  }

  Widget _buildCarouselSlider(CarouselModel item) {
    return Builder(builder: (context) {
      return Container(
          width: MediaQuery.of(context).size.width,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Image.asset(item.imageUrl),
            SizedBox(height: 16),
            Row(children: [
              Image.asset(item.avatarUrl, width: 28, height: 28),
              SizedBox(width: 8),
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Text(item.name,
                        style: GoogleFonts.roboto(
                            fontSize: 13, fontWeight: FontWeight.w700)),
                    Text(item.nickname, style: GoogleFonts.roboto(fontSize: 11))
                  ]))
            ])
          ]));
    });
  }

  Widget _buildImageGridView() {
    return StaggeredGridView.countBuilder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      crossAxisCount: 2,
      itemCount: _gridImgs.length,
      itemBuilder: (BuildContext context, int index) => Image.asset(
        _gridImgs[index],
        fit: BoxFit.cover,
      ),
      staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
      mainAxisSpacing: 10.0,
      crossAxisSpacing: 10.0,
    );
  }
}
