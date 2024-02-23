import 'package:flutter/material.dart';

class BadgeWidget extends StatelessWidget {
  final double top;
  final double right;
  final Widget child;
  final int value;
  final Color? color;

  BadgeWidget({
    required this.top,
    required this.right,
    required this.child,
    required this.value,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        child,
        value == 0
            ? Container()
            : Positioned(
                right: this.right,
                top: this.top,
                child: Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: color ?? Colors.red),
                  child: Text(
                    value.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                  ),
                ),
              )
      ],
    );
  }
}
