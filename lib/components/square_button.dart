import 'package:flutter/material.dart';

class SquareButton extends StatelessWidget {
  final Function() onTap;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final String text;
  final TextStyle textStyle;
  final double radius;
  final Color btnColor;
  final BoxBorder boxBorder;
  final bool isExpanded;

  const SquareButton(
      {Key key,
      @required this.onTap,
      this.padding,
      this.margin,
      @required this.text,
      this.textStyle,
      this.radius = 6,
      this.btnColor = Colors.white,
      this.boxBorder,
      this.isExpanded = false})
      : super(key: key);

  factory SquareButton.expanded(
      {@required Function() onTap,
      EdgeInsets padding,
      EdgeInsets margin,
      @required String text,
      TextStyle textStyle,
      double radius = 6,
      Color btnColor = Colors.white,
      BoxBorder boxBorder}) {
    return SquareButton(
      onTap: onTap,
      text: text,
      padding: padding,
      margin: margin,
      textStyle: textStyle,
      radius: radius,
      btnColor: btnColor,
      boxBorder: boxBorder,
      isExpanded: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return isExpanded
        ? Expanded(
            child: InkWell(
              onTap: onTap,
              child: Container(
                padding: padding ?? EdgeInsets.symmetric(vertical: 19),
                margin: margin ?? EdgeInsets.zero,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: btnColor,
                    borderRadius: BorderRadius.circular(radius),
                    border: boxBorder ?? Border()),
                child: Text(
                  text,
                  style: textStyle,
                ),
              ),
            ),
          )
        : InkWell(
            onTap: onTap,
            child: Container(
              padding: padding ?? EdgeInsets.symmetric(vertical: 19),
              margin: margin ?? EdgeInsets.zero,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: btnColor,
                  borderRadius: BorderRadius.circular(radius),
                  border: boxBorder ?? Border()),
              child: Text(
                text,
                style: textStyle,
              ),
            ),
          );
  }
}
