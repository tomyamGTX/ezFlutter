import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

/// An example showing how to drive a StateMachine via a trigger input.
class LittleMachine extends StatefulWidget {
  const LittleMachine({Key? key}) : super(key: key);

  @override
  _LittleMachineState createState() => _LittleMachineState();
}

class _LittleMachineState extends State<LittleMachine> {
  /// Tracks if the animation is playing by whether controller is running.
  bool get isPlaying => _controller?.isActive ?? false;

  /// Message that displays when state has changed
  String stateChangeMessage = '';

  Artboard? _riveArtboard;
  StateMachineController? _controller;
  SMIInput<bool>? _trigger;

  @override
  void initState() {
    super.initState();

    // Load the animation file from the bundle, note that you could also
    // download this. The RiveFile just expects a list of bytes.
    rootBundle.load('asset/rives/little_machine.riv').then(
      (data) async {
        // Load the RiveFile from the binary data.
        final file = RiveFile.import(data);

        // The artboard is the root of the animation and gets drawn in the
        // Rive widget.
        final artboard = file.mainArtboard;
        var controller = StateMachineController.fromArtboard(
          artboard,
          'State Machine 1',
        );
        if (controller != null) {
          artboard.addController(controller);
          _trigger = controller.findInput('Trigger 1');
        }
        setState(() => _riveArtboard = artboard);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: const Text('Little Machine'),
        centerTitle: true,
      ),
      body: Center(
        child: _riveArtboard == null
            ? const SizedBox()
            : GestureDetector(
                onTapDown: (_) => _trigger?.value = true,
                child: Stack(
                  children: [
                    Rive(
                      artboard: _riveArtboard!,
                      fit: BoxFit.cover,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Press to activate!',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(stateChangeMessage),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
