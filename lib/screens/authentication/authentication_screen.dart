import 'package:example/commons/app_assets.dart';
import 'package:example/components/square_button.dart';
import 'package:example/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthenticationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildImage(context),
          _buildBottomBar(context),
        ],
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Expanded(
        child: Stack(fit: StackFit.expand, children: [
      Image.asset(AssetsPNG.home, fit: BoxFit.cover),
      Center(
        child: Image.asset(AssetsPNG.icPhoto, width: _width * 206 / 375),
      ),
      _buildAuthor(),
    ]));
  }

  Widget _buildAuthor() {
    return Positioned.fill(
        child: Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child:
                    Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  Image.asset(AssetsPNG.member1, width: 28, height: 28),
                  SizedBox(width: 8),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Pawel Czerwinski",
                            style: GoogleFonts.roboto(
                                fontSize: 13, fontWeight: FontWeight.w700)),
                        Text("@pawel_czerwinski",
                            style: GoogleFonts.roboto(fontSize: 11))
                      ])
                ]))));
  }

  Widget _buildBottomBar(BuildContext context) {
    TextStyle _style =
        GoogleFonts.roboto(fontSize: 13, fontWeight: FontWeight.w900);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SquareButton.expanded(
            onTap: () {
              Navigator.of(context).pushNamed(RoutesName.login);
            },
            text: "LOG IN",
            textStyle: _style,
            boxBorder: Border.all(color: Colors.black, width: 2),
          ),
          SizedBox(width: 10),
          SquareButton.expanded(
            onTap: () {
              Navigator.of(context).pushNamed(RoutesName.register1);
            },
            text: "REGISTER",
            btnColor: Colors.black,
            textStyle: _style.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
