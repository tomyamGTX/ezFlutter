/// Demonstrates playing a one-shot animation on demand

import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class PlayOneShotAnimation extends StatefulWidget {
  const PlayOneShotAnimation({Key? key}) : super(key: key);

  @override
  _PlayOneShotAnimationState createState() => _PlayOneShotAnimationState();
}

class _PlayOneShotAnimationState extends State<PlayOneShotAnimation> {
  /// Controller for playback
  late RiveAnimationController _controller;

  /// Is the animation currently playing?
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff03c64),
      appBar: AppBar(
        title: const Text('One-Shot Example'),
        centerTitle: true,
      ),
      body: const Center(
        child: RiveAnimation.network(
          'https://cdn.rive.app/animations/vehicles.riv',
          animations: ['idle', 'curves'],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // disable the button while playing the animation
        onPressed: () => _isPlaying ? null : _controller.isActive = true,
        tooltip: 'Bounce',
        child: const Icon(Icons.arrow_upward),
      ),
    );
  }
}
