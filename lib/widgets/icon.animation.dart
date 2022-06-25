import 'package:animator/animator.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class AnimationIcon extends StatefulWidget {
  final IconData icon;
  final int index;
  final String text;

  const AnimationIcon(
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
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      height: w / 1.75,
      width: w / 2,
      child: Animator<double>(
        duration: const Duration(milliseconds: 2000),
        cycles: 0,
        curve: Curves.easeInOut,
        tween: Tween<double>(begin: 0.0, end: 10.0),
        builder: (context, animatorState, child) => Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: animatorState.value * 2,
            ),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).primaryColorLight,
                    blurRadius: 20,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Icon(
                widget.icon,
                color: Theme.of(context).primaryColor,
                size: 32,
              ),
            ),
            AutoSizeText(
              widget.text,
              style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).primaryColorDark,
                  fontWeight: FontWeight.w300),
              maxLines: 2,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
