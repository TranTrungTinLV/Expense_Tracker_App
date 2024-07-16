import 'package:flutter/material.dart';

class Carousel extends StatelessWidget {
  final IconData icon;
  final String title;
  final double horizontal;
  final double vertical;
  final Color? coulor;
  const Carousel({
    super.key,
    required this.icon,
    required this.title,
    required this.horizontal,
    required this.vertical,
    this.coulor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 9.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
            child: Icon(icon),
          ),
          Text(
            title,
            style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w500),
          )
        ],
      ),
      margin: EdgeInsets.symmetric(vertical: vertical, horizontal: horizontal),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 2,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          // color: Colors.green,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0),
              bottomLeft: Radius.circular(15.0),
              bottomRight: Radius.circular(15.0),
              topRight: Radius.circular(15.0))),
      width: 100,
      height: 48,
    );
  }
}
