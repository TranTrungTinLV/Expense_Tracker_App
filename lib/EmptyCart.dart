import 'package:flutter/material.dart';

const Color colorText = Color(0xFF242D35);
Color _color = Colors.white;

class EmptyCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String amount;
  final double horizontal;
  final double vertical;
  final Color? coulor;
  final Color? cardCoulor;

  final VoidCallback? onTap;
  const EmptyCard(
      {super.key,
      required this.icon,
      required this.title,
      required this.amount,
      this.horizontal = 8.0,
      this.vertical = 10.0,
      this.coulor = colorText,
      this.cardCoulor,
      this.onTap});

  @override
  State<EmptyCard> createState() => _EmptyCardState();
}

class _EmptyCardState extends State<EmptyCard> {
  bool _isTapped = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        setState(() {
          _isTapped = true;
        });
      },
      onTapUp: (details) {
        setState(() {
          _isTapped = false;
        });
        if (widget.onTap != null) {
          widget.onTap!();
        }
      },
      onTapCancel: () {
        setState(() {
          _isTapped = false;
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(
            vertical: widget.vertical, horizontal: widget.horizontal),
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(1, -1),
              end: Alignment(-1, 1),
              stops: <double>[0, 1],
              colors: !_isTapped
                  ? [Colors.white, Colors.white]
                  : [Colors.white, Colors.white],
            ),
            // color: widget.cardCoulor,
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 2,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ]),
        height: 140.0,
        width: 200.0,
        child: Container(
          width: 90,
          margin: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                  height: 60,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        widget.icon,
                        color: !_isTapped ? Color(0xFF242D35) : Colors.black,
                      ),
                      Container(
                        height: 8,
                      ),
                      Text(
                        widget.title,
                        style: TextStyle(
                            fontSize: 18.0,
                            color:
                                !_isTapped ? Color(0xFF242D35) : Colors.black),
                      ),
                    ],
                  )),
              Text(widget.amount,
                  style: TextStyle(
                      fontSize: 24.0,
                      letterSpacing: 0.32,
                      color: !_isTapped ? Color(0xFF242D35) : Colors.black)),
            ],
          ),
        ),
      ),
    );
  }
}
