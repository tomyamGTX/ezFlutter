import 'package:animator/animator.dart';
import 'package:flutter/material.dart';

class AnimationIcon extends StatefulWidget {
  final IconData icon;
  final int index;
  final String text;
  AnimationIcon(
      {required this.index, required this.icon, required this.text, Key? key})
      : super(key: key);

  @override
  _AnimationIconState createState() => _AnimationIconState();
}

class _AnimationIconState extends State<AnimationIcon> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColorLight,
          borderRadius: BorderRadius.circular(8)),
      height: w / 2.75,
      width: w / 4,
      child: Animator<double>(
        duration: Duration(milliseconds: 5000 - widget.index * 1000),
        cycles: 0,
        curve: Curves.easeInOut,
        tween: Tween<double>(begin: 0.0, end: 10.0),
        builder: (context, animatorState, child) => Column(
          children: [
            SizedBox(
              height: animatorState.value * 1.2,
            ),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.pink.withOpacity(.15),
                    blurRadius: 20,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Icon(
                widget.icon,
                color: Colors.pink,
                size: 32,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                widget.text,
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
