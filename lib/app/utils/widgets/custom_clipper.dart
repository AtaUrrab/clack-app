import 'package:flutter/material.dart';

class Triangle extends StatelessWidget {
  final bool leftSideOpen;

  const Triangle({
    Key? key,
    required this.leftSideOpen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: TriangleClipper(leftSideOpen: leftSideOpen),
      child: Container(
        height: 200,
        width: 195,
        color: Colors.white,
      ),
    );
  }
}

class TriangleClipper extends CustomClipper<Path> {
  final bool leftSideOpen;

  TriangleClipper({required this.leftSideOpen});

  @override
  Path getClip(Size size) {
    final path = Path();
    if (leftSideOpen) {
      path.moveTo(size.width, 0);
      path.lineTo(0, size.height);
      path.lineTo(size.width, size.height);
      path.close();
    } else {
      path.lineTo(0, size.height);
      path.lineTo(size.width, size.height);
      path.close();
    }
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
