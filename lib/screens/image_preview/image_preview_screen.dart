import 'package:example/screens/home/models/image_information.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../commons/app_dimension.dart';

class ImagePreviewScreen extends StatelessWidget {
  final ImageInformation image;
  const ImagePreviewScreen({Key key, @required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Container(
        height: AppDimension.shared.height,
        child: Hero(
          tag: this.image.imageUrl,
          child: Image.asset(
            this.image.imageUrl,
            fit: BoxFit.fill,
          ),
        ),
      ),
      Positioned.fill(
          child: Align(
              alignment: Alignment.topCenter,
              child: SafeArea(
                  child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildUserInfor(),
                            _buildCloseBtn(context)
                          ])))))
    ]));
  }

  Widget _buildUserInfor() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(this.image.avatarUrl, width: 28, height: 28),
        SizedBox(width: 8),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(this.image.name,
              style: GoogleFonts.roboto(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: Colors.white)),
          Text(this.image.nickname,
              style: GoogleFonts.roboto(fontSize: 11, color: Colors.white))
        ])
      ],
    );
  }

  Widget _buildCloseBtn(BuildContext context) {
    return InkWell(
      onTap: Navigator.of(context).pop,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(shape: BoxShape.circle),
        child: Icon(Icons.close, color: Colors.white, size: 18),
      ),
    );
  }
}
